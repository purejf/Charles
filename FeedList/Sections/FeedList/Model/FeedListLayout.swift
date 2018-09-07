//
//  FeedListLayout.swift
//  FeedList
//
//  Created by y on 2018/9/7.
//  Copyright © 2018年 SunLands.com. All rights reserved.
//

import UIKit

class FeedListViewLayout_Pic: NSObject {
    
    @objc var listM: FeedListModel?
    
    @objc var contentR: CGRect = CGRect.zero
    @objc var imageRs: [NSValue]?
}

class FeedListViewLayout_Video: NSObject {
    
    @objc var listM: FeedListModel?
    
    @objc var contentR: CGRect = CGRect.zero
    @objc var videoPlayR: CGRect = CGRect.zero
}

class FeedListViewLayout_Web: NSObject {
    
    @objc var listM: FeedListModel?
    
    @objc var contentR: CGRect = CGRect.zero
    @objc var webIconR: CGRect = CGRect.zero
    @objc var webTitleR: CGRect = CGRect.zero
}

class FeedListLayout: NSObject {
    
    private let iconTop: CGFloat = 15.0
    private let iconWH: CGFloat = 44.0
    private let margin: CGFloat = 10.0
    private let imageCount: Int = 9
    private let imageRow: Int = 3
    
    @objc var iconR: CGRect = CGRect.zero
    @objc var nameR: CGRect = CGRect.zero
    
    @objc var contentR: CGRect = CGRect.zero
    @objc var contentAttString: NSAttributedString?
    
    @objc var pic: FeedListViewLayout_Pic?
    @objc var video: FeedListViewLayout_Video?
    @objc var web: FeedListViewLayout_Web?
    
    @objc var timeR: CGRect = CGRect.zero
    
    @objc var height: CGFloat = 0
    
    @objc var listM: FeedListModel? {
        didSet {
            if let listM_ = listM {
                let nameW: CGFloat = UIScreen.main.bounds.size.width - iconTop - iconWH - margin * 2.0
                let nameLeft: CGFloat = iconTop + iconWH + margin
                iconR = CGRect(x: iconTop, y: iconTop, width: iconWH, height: iconWH)
                
                nameR = CGRect(x: nameLeft, y: iconTop, width: nameW, height: 0)
                if let name = listM_.name {
                    if (name.count > 0) {
                        var rect = nameR
                        rect.size.height = 20
                        nameR = rect
                    }
                }
                
                contentR = CGRect(x: nameLeft, y: nameR.height > 0 ? nameR.maxY + margin : nameR.maxY, width: nameW, height: 0)
                if let content = listM_.content {
                    if (content.count > 0) {
                        let style = NSMutableParagraphStyle()
                        style.lineSpacing = 3.0
                        let atts = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14),
                                    NSAttributedStringKey.foregroundColor: UIColor.black,
                                    NSAttributedStringKey.paragraphStyle: style]
                        let contentAttStr = NSMutableAttributedString.init(string: content)
                        contentAttStr.addAttributes(atts, range: NSMakeRange(0, content.count))
                        contentAttString = (contentAttStr.copy() as! NSAttributedString)
                        let size = contentAttString!.boundingRect(with: CGSize(width: nameW, height: CGFloat(MAXFLOAT)),
                                                                  options: .usesLineFragmentOrigin,
                                                                  context: nil).size
                        var rect = contentR
                        rect.size.height = size.height
                        contentR = rect
                    }
                }
                
                pic = nil
                video = nil
                web = nil
                switch listM_.type {
                case FeedListModelType.None.rawValue: break
                case FeedListModelType.Pic.rawValue:
                    if let images = listM_.images {
                        if (images.count > 0) {
                            pic = FeedListViewLayout_Pic()
                            pic!.listM = listM_
                            
                            // contentR
                            let x = nameLeft
                            let y = contentR.maxY + margin
                            let w = nameW
                            let singleWH = (nameW - CGFloat(imageRow - 1) * margin) / CGFloat(imageRow)
                            let row = (images.count + 1) / imageRow
                            var contentH = singleWH * CGFloat(row)
                            if row > 1 {
                                contentH += margin * CGFloat(row - 1)
                            }
                            pic!.contentR = CGRect(x: x, y: y, width: w, height: contentH)
                            
                            // imageRs
                            let count = images.count > imageCount ? imageCount : images.count;
                            let imageRs_ = NSMutableArray()
                            for i in 0..<count {
                                let rect = CGRect(x: (singleWH + margin) * CGFloat(i % imageRow), y: (singleWH + margin) * CGFloat(i / imageRow), width: singleWH, height: singleWH)
                                let value = NSValue(cgRect: rect)
                                imageRs_.add(value)
                            }
                            pic!.imageRs = (imageRs_.copy() as! [NSValue])
                        }
                    }
                    break
                case FeedListModelType.Video.rawValue:
                    if let videoUrl = listM_.videoUrl {
                        if (videoUrl.count > 0) {
                            video = FeedListViewLayout_Video()
                            video!.listM = listM_
                            
                            let x = nameLeft
                            let y = contentR.maxY + margin
                            let w = nameW
                            let h = nameW
                            video!.contentR = CGRect(x: x, y: y, width: w, height: h)
                            let playWH: CGFloat = 44
                            video!.videoPlayR = CGRect(x: (w - playWH) / CGFloat(2.0), y: (h - playWH) / CGFloat(2.0), width: playWH, height: playWH)
                        }
                    }
                    break
                case FeedListModelType.Web.rawValue:
                    if let title = listM_.webTitle, let url = listM_.webUrl {
                        if (url.count > 0 && title.count > 0) {
                            web = FeedListViewLayout_Web()
                            web!.listM = listM_
                            
                            let x = nameLeft
                            let y = contentR.maxY + margin
                            let w = nameW
                            let h: CGFloat = 44
                            let iconLeft: CGFloat = 5
                            let iconWH: CGFloat = h - iconLeft * 2
                            web!.contentR = CGRect(x: x, y: y, width: w, height: h)
                            web!.webIconR = CGRect(x: iconLeft, y: iconLeft, width: iconWH, height: iconWH)
                            web!.webTitleR = CGRect(x: web!.webIconR.maxX + iconLeft, y: iconLeft, width: w - web!.webIconR.maxX - iconLeft * 2, height: iconWH)
                        }
                    }
                    break
                default:
                    break
                }
                
                if let pic = pic {
                    timeR = CGRect(x: nameLeft, y: pic.contentR.maxY + margin, width: nameW, height: 20)
                } else if let video = video {
                    timeR = CGRect(x: nameLeft, y: video.contentR.maxY + margin, width: nameW, height: 20)
                } else if let web = web {
                    timeR = CGRect(x: nameLeft, y: web.contentR.maxY + margin, width: nameW, height: 20)
                } else {
                    timeR = CGRect(x: nameLeft, y: contentR.maxY + 10, width: nameW, height: 20)
                }
                height = timeR.maxY + margin
            }
        }
    }
    
}

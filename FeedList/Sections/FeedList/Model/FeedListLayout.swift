//
//  FeedListLayout.swift
//  FeedList
//
//  Created by y on 2018/9/7.
//  Copyright © 2018年 Charles. All rights reserved.
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

let kRowCount: UInt = 8

class FeedListLayout: NSObject {
    
    private let iconTop: CGFloat = 15.0
    private let iconWH: CGFloat = 44.0
    private let margin: CGFloat = 7.0
    private let imageCount: Int = 9
    private let imageRow: Int = 3
    
    @objc var showOpening: Bool = false
    @objc var opening: Bool = false
    @objc var openingItemR: CGRect = CGRect.zero
    
    @objc var iconR: CGRect = CGRect.zero
    @objc var nameR: CGRect = CGRect.zero
    
    @objc var contentR: CGRect = CGRect.zero
    @objc var contentLayout: YYTextLayout?
    
    @objc var pic: FeedListViewLayout_Pic?
    @objc var video: FeedListViewLayout_Video?
    @objc var web: FeedListViewLayout_Web?
    
    @objc var locationR: CGRect = CGRect.zero
    @objc var timeR: CGRect = CGRect.zero
    @objc var height: CGFloat = 0
    
    @objc var listM: FeedListModel?
    
    func layout() {
        guard let listM_ = listM else { return }
        let nameW: CGFloat = UIScreen.main.bounds.size.width - iconTop - iconWH - margin * 3.0
        let nameLeft: CGFloat = iconTop + iconWH + margin
        iconR = CGRect(x: iconTop, y: iconTop, width: iconWH, height: iconWH)
        nameR = CGRect(x: nameLeft, y: iconTop, width: nameW, height: 0)
        if let name = listM_.name, name.count > 0 {
            var rect = nameR
            rect.size.height = 20
            nameR = rect
        }
        contentR = CGRect(x: nameLeft, y: nameR.height > 0 ? nameR.maxY + margin : nameR.maxY, width: nameW, height: 0)
        if let content = listM_.content, content.count > 0 {
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 3.0
            let atts = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12),
                        NSAttributedStringKey.foregroundColor: UIColor.black,
                        NSAttributedStringKey.paragraphStyle: style]
            let contentAttStr = NSMutableAttributedString.init(string: content)
            contentAttStr.addAttributes(atts, range: NSMakeRange(0, content.count))
            
            // layout
            let container = YYTextContainer(size: CGSize(width: nameW, height: CGFloat(MAXFLOAT)))
            var contentLayout_ = YYTextLayout(container: container, text: contentAttStr)!
            if contentLayout_.rowCount > kRowCount {
                if !opening {
                    container.maximumNumberOfRows = kRowCount
                    container.truncationType = .end
                    contentLayout_ = YYTextLayout(container: container, text: contentAttStr)!
                }
                showOpening = true
            } else {
                showOpening = false
            }
            contentLayout = contentLayout_
            var rect = contentR
            rect.size.height = contentLayout_.textBoundingSize.height
            contentR = rect
            if showOpening {
                let x = nameLeft
                let y: CGFloat = contentR.maxY + margin
                let w: CGFloat = 30
                let h: CGFloat = 18
                openingItemR = CGRect(x: x, y: y, width: w, height: h)
            }
        }
        pic = nil
        video = nil
        web = nil
        switch listM_.type {
        case FeedListModelType.None.rawValue: break
        case FeedListModelType.Pic.rawValue:
            if let images = listM_.images, images.count > 0 {
                pic = FeedListViewLayout_Pic()
                pic!.listM = listM_
                let x = nameLeft
                var y = contentR.maxY + margin
                if showOpening {
                    y = openingItemR.maxY + margin
                }
                let w: CGFloat = UIScreen.main.bounds.width - nameLeft * 2.0
                let singleWH = (w - CGFloat(imageRow - 1) * margin) / CGFloat(imageRow)
                var row = images.count / imageRow
                if images.count % imageRow > 0 {
                    row += 1
                }
                let contentH = singleWH * CGFloat(row) + margin * CGFloat(row - 1) 
                pic!.contentR = CGRect(x: x, y: y, width: w, height: contentH)
                let count = images.count > imageCount ? imageCount : images.count;
                var imageRs_ = [NSValue]()
                for i in 0..<count {
                    let rect = CGRect(x: (singleWH + margin) * CGFloat(i % imageRow), y: (singleWH + margin) * CGFloat(i / imageRow), width: singleWH, height: singleWH)
                    let value = NSValue(cgRect: rect)
                    imageRs_.append(value)
                }
                pic!.imageRs = imageRs_
            }
            break
        case FeedListModelType.Video.rawValue:
            if let videoUrl = listM_.videoUrl, videoUrl.count > 0{
                video = FeedListViewLayout_Video()
                video!.listM = listM_
                let x = nameLeft
                var y = contentR.maxY + margin
                if showOpening {
                    y = openingItemR.maxY + margin
                }
                let w = nameW
                let h = nameW * 9 / 16
                video!.contentR = CGRect(x: x, y: y, width: w, height: h)
                let playWH: CGFloat = 44
                video!.videoPlayR = CGRect(x: (w - playWH) / CGFloat(2.0), y: (h - playWH) / CGFloat(2.0), width: playWH, height: playWH)
            }
            break
        case FeedListModelType.Web.rawValue:
            if let title = listM_.webTitle, let url = listM_.webUrl, url.count > 0 && title.count > 0 {
                web = FeedListViewLayout_Web()
                web!.listM = listM_
                let x = nameLeft
                var y = contentR.maxY + margin
                if showOpening {
                    y = openingItemR.maxY + margin
                }
                let w = nameW
                let h: CGFloat = 44
                let iconLeft: CGFloat = 5
                let iconWH: CGFloat = h - iconLeft * 2
                web!.contentR = CGRect(x: x, y: y, width: w, height: h)
                web!.webIconR = CGRect(x: iconLeft, y: iconLeft, width: iconWH, height: iconWH)
                web!.webTitleR = CGRect(x: web!.webIconR.maxX + iconLeft, y: iconLeft, width: w - web!.webIconR.maxX - iconLeft * 2, height: iconWH)
            }
            break
        default:
            break
        }
        if let location = listM_.location, location.count > 0 {
            if let pic = pic {
                locationR = CGRect(x: nameLeft, y: pic.contentR.maxY + margin, width: nameW, height: 20)
            } else if let video = video {
                locationR = CGRect(x: nameLeft, y: video.contentR.maxY + margin, width: nameW, height: 20)
            } else if let web = web {
                locationR = CGRect(x: nameLeft, y: web.contentR.maxY + margin, width: nameW, height: 20)
            } else {
                var y = contentR.maxY + margin
                if showOpening {
                    y = openingItemR.maxY + margin
                }
                locationR = CGRect(x: nameLeft, y: y, width: nameW, height: 20)
            }
        } else {
            var y = contentR.maxY + margin
            if showOpening {
                y = openingItemR.maxY + margin
            }
            locationR = CGRect(x: nameLeft, y: y, width: nameW, height: 0)
        }
        var timeY = locationR.maxY;
        if locationR.height > 0 {
            timeY += margin
        }
        var timeH:CGFloat = 0
        if let time = listM_.time, time.count > 0 {
            timeH = 20
        }
        timeR = CGRect(x: nameLeft, y: timeY, width: nameW, height: timeH)
        height = timeR.maxY + margin
    }
}

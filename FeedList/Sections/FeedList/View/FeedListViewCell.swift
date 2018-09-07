//
//  FeedListViewCell.swift
//  FeedList
//
//  Created by y on 2018/9/7.
//  Copyright © 2018年 SunLands.com. All rights reserved.
//

import UIKit

// MARK: -
class FeedListViewCell_Pic: UIView {
    @objc var layout: FeedListViewLayout_Pic? {
        didSet {
            if let layout = layout, let listM = layout.listM, let imageRs = layout.imageRs, let images = listM.images {
                if (imageRs.count > 0 && images.count >= imageRs.count) {
                    isHidden = false
                    frame = layout.contentR
                    if (imageRs.count > subviews.count) {
                        for _ in 0..<imageRs.count - subviews.count {
                            let image = UIImageView()
                            addSubview(image)
                        }
                    } else if (imageRs.count < subviews.count) {
                        for i in 0..<subviews.count - imageRs.count {
                            let image = subviews[i]
                            image.isHidden = true
                        }
                    }
                    for i in 0..<imageRs.count {
                        let image = subviews[i] as! UIImageView
                        image.isHidden = false
                        let rect = imageRs[i].cgRectValue
                        image.frame = rect
                        guard let url = URL(string: images[i]) else {
                            continue
                        }
                        image.sd_setImage(with: url, placeholderImage: nil, options: .retryFailed, completed: nil)
                    }
                } else {
                    isHidden = true
                }
            } else {
                isHidden = true
            }
            
            
        }
    }
}

// MARK: -
class FeedListViewCell_Video: UIView {
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(cover)
        addSubview(playItem)
    }
    
    @objc var layout: FeedListViewLayout_Video? {
        didSet {
            if let layout = layout, let listM = layout.listM {
                frame = layout.contentR
                cover.frame = bounds
                playItem.frame = layout.videoPlayR
                
                if let videoCover = listM.videoCover {
                    guard let url = URL(string: videoCover) else {
                        return
                    }
                    cover.sd_setImage(with: url, placeholderImage: nil, options: .retryFailed, completed: nil)
                }
            }
        }
    }
    
    // MARK: - Lazy
    lazy var cover: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        return image
    }()
    
    lazy var playItem: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.image = UIImage(named: "video_play")
        return image
    }()
}

// MARK: -
class FeedListViewCell_Web: UIView {
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        addSubview(titleL)
        addSubview(icon)
    }
    
    @objc var layout: FeedListViewLayout_Web? {
        didSet {
            if let layout = layout, let listM = layout.listM {
                frame = layout.contentR
                icon.frame = layout.webIconR
                titleL.frame = layout.webTitleR
                titleL.text = layout.listM?.webTitle
                if let iconUrl = listM.webIcon {
                    guard let url = URL(string: iconUrl) else {
                        return
                    }
                    icon.sd_setImage(with: url, placeholderImage: nil, options: .retryFailed, completed: nil)
                }
            }
        }
    }
    
    // MARK: - Lazy
    lazy var titleL: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var icon: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 3.0
        return image
    }()
    
}

// MARK: -

class FeedListViewCell: UITableViewCell {
    
    // MARK: - Init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(hue:0.00, saturation:0.00, brightness:0.96, alpha:1.00)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(nameL)
        contentView.addSubview(icon)
        contentView.addSubview(contentL)
        contentView.addSubview(pic)
        contentView.addSubview(video)
        contentView.addSubview(web)
        contentView.addSubview(timeL)
    }
    
    var layout: FeedListLayout? {
        didSet {
            if let layout = layout, let listM = layout.listM {
                icon.frame = layout.iconR
                if let iconUrl = listM.icon {
                    guard let url = URL(string: iconUrl) else {
                        return
                    }
                    icon.sd_setImage(with: url, placeholderImage: nil, options: .retryFailed, completed: nil)
                }
                // 设置url
                nameL.isHidden = true
                if (layout.nameR.height > 0) {
                    nameL.isHidden = false
                    nameL.frame = layout.nameR
                    nameL.text = listM.name
                }
                
                contentL.isHidden = true
                if (layout.contentR.height > 0) {
                    contentL.isHidden = false
                    contentL.frame = layout.contentR
                    contentL.attributedText = layout.contentAttString
                }
                
                pic.isHidden = true
                video.isHidden = true
                web.isHidden = true
                
                if (listM.type == FeedListModelType.Pic.rawValue && layout.pic != nil) {
                    pic.isHidden = false
                    pic.layout = layout.pic
                } else if (listM.type == FeedListModelType.Video.rawValue && layout.video != nil) {
                    video.isHidden = false
                    video.layout = layout.video
                } else if (listM.type == FeedListModelType.Web.rawValue && layout.web != nil) {
                    web.isHidden = false
                    web.layout = layout.web
                }
                
                timeL.frame = layout.timeR
                timeL.text = listM.time
            }
        }
    }
    
    // MARK: - Lazy
    lazy var nameL: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.blue
        return label
    }()
    
    lazy var icon: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 3.0
        return image
    }()
    
    lazy var contentL: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.blue
        return label
    }()
    
    lazy var pic: FeedListViewCell_Pic = {
        let pic = FeedListViewCell_Pic()
        return pic
    }()
    
    lazy var video: FeedListViewCell_Video = {
        let video = FeedListViewCell_Video()
        return video
    }()
    
    lazy var web: FeedListViewCell_Web = {
        let web = FeedListViewCell_Web()
        return web
    }()
    
    lazy var timeL: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.blue
        return label
    }()
    
}


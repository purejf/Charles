//
//  FeedListViewCell.swift
//  FeedList
//
//  Created by y on 2018/9/7.
//  Copyright © 2018年 Charles. All rights reserved.
//

import UIKit

// MARK: -

class FeedListViewCell_Pic: UIView {
    
    weak var cell: FeedListViewCell?
    
    @objc private func imageTapGestHandle(_ tap: UITapGestureRecognizer) {
        if let tapView = tap.view {
            let index = subviews.index(of: tapView)
            if let cell = cell, let callBack = cell.picItemClickCallBack {
                callBack(cell, tapView as! UIImageView, index!)
            }
        }
    }
    
    @objc var layout: FeedListViewLayout_Pic? {
        didSet {
            if let layout = layout, let listM = layout.listM, let imageRs = layout.imageRs, let images = listM.images {
                if imageRs.count > 0 && images.count >= imageRs.count {
                    isHidden = false
                    frame = layout.contentR
                    if imageRs.count > subviews.count {
                        for _ in 0..<imageRs.count - subviews.count {
                            let image = UIImageView()
                            image.backgroundColor = UIColor.lightGray
                            image.isUserInteractionEnabled = true
                            image.layer.masksToBounds = true
                            image.contentMode = .scaleAspectFill
                            let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapGestHandle(_:)))
                            image.addGestureRecognizer(tap)
                            addSubview(image)
                        }
                    } else if imageRs.count < subviews.count {
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
                        let url = URL(string: images[i])
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
    
    weak var cell: FeedListViewCell?
    
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
                    let url = URL(string: videoCover)
                    cover.sd_setImage(with: url, placeholderImage: nil, options: .retryFailed, completed: nil)
                }
            }
        }
    }
    
    @objc private func playItemTapGestHandle() {
        if let cell = cell, let videoItemClickCallBack = cell.videoItemClickCallBack {
            videoItemClickCallBack(cell)
        }
    }
    
    // MARK: - Lazy
    
    lazy var cover: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var playItem: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.image = UIImage(named: "video_play")
        image.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(playItemTapGestHandle))
        image.addGestureRecognizer(tap)
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
                titleL.text = listM.webTitle
                if let iconUrl = listM.webIcon {
                    let url = URL(string: iconUrl)
                    icon.sd_setImage(with: url, placeholderImage: nil, options: .retryFailed, completed: nil)
                }
            }
        }
    }
    
    // MARK: - Lazy
    
    lazy var titleL: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var icon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 3.0
        return image
    }()
}

// MARK: -

class FeedListViewCell: UITableViewCell {
    
    typealias FeedListViewCellItemClickCallBack = (_ cell: FeedListViewCell) -> Void
    typealias FeedListViewCellPicItemClickCallBack = (_ cell: FeedListViewCell, _ pic: UIImageView, _ index: Int) -> Void
    
    var openItemClickCallBack: FeedListViewCellItemClickCallBack?
    var videoItemClickCallBack: FeedListViewCellItemClickCallBack?
    
    var picItemClickCallBack: FeedListViewCellPicItemClickCallBack?
    
    // MARK: - Init
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(hue:0.00, saturation:0.00, brightness:0.96, alpha:1.00)
        selectionStyle = .none
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(nameL)
        contentView.addSubview(icon)
        contentView.addSubview(contentL)
        contentView.addSubview(openItem)
        contentView.addSubview(pic)
        contentView.addSubview(video)
        contentView.addSubview(web)
        contentView.addSubview(locationL)
        contentView.addSubview(timeL)
    }
    
    var layout: FeedListLayout? {
        didSet {
            if let layout = layout, let listM = layout.listM {
                icon.frame = layout.iconR
                if let iconUrl = listM.icon {
                    let url = URL(string: iconUrl)
                    icon.sd_setImage(with: url, placeholderImage: nil, options: .retryFailed, completed: nil)
                }
                // 设置url
                nameL.isHidden = true
                if layout.nameR.height > 0 {
                    nameL.isHidden = false
                    nameL.frame = layout.nameR
                    nameL.text = listM.name
                }
                
                contentL.isHidden = true
                openItem.isHidden = true
                if let contentLayout = layout.contentLayout {
                    contentL.isHidden = false
                    contentL.frame = layout.contentR
                    contentL.textLayout = contentLayout
                    if layout.showOpening {
                        openItem.isHidden = false
                        openItem.frame = layout.openingItemR
                    }
                    if layout.opening {
                        openItem.text = "收起"
                    } else {
                        openItem.text = "展开"
                    }
                }
                
                pic.isHidden = true
                video.isHidden = true
                web.isHidden = true
                
                if listM.type == FeedListModelType.Pic.rawValue && layout.pic != nil {
                    pic.isHidden = false
                    pic.layout = layout.pic
                } else if listM.type == FeedListModelType.Video.rawValue && layout.video != nil {
                    video.isHidden = false
                    video.layout = layout.video
                } else if listM.type == FeedListModelType.Web.rawValue && layout.web != nil {
                    web.isHidden = false
                    web.layout = layout.web
                }
                
                locationL.isHidden = true
                if layout.locationR.height > 0 {
                    locationL.isHidden = false
                    locationL.frame = layout.locationR
                    locationL.text = listM.location
                }
                
                timeL.isHidden = true
                if layout.timeR.height > 0 {
                    timeL.isHidden = false
                    timeL.frame = layout.timeR
                    timeL.text = listM.time
                }
            }
        }
    }
    
    // MARK: - Actions
    
    @objc private func openItemTapGestHandle() {
        if let callBack = openItemClickCallBack, let layout = layout {
            layout.opening = !layout.opening
            layout.layout()
            callBack(self)
        }
    }
    
    // MARK: - Lazy
    
    lazy var nameL: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor(hexString: "#4C6C91")
        return label
    }()
    
    lazy var icon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 3.0
        return image
    }()
    
    lazy var locationL: YYLabel = {
        let label = YYLabel()
        label.numberOfLines = 1
        label.textColor = UIColor(hexString: "#4C6C91")
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()
    
    lazy var contentL: YYLabel = {
        let label = YYLabel()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var openItem: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor(hexString: "#4C6C91")
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(openItemTapGestHandle))
        label.addGestureRecognizer(tap)
        return label
    }()
    
    lazy var pic: FeedListViewCell_Pic = {
        let pic = FeedListViewCell_Pic()
        pic.cell = self
        return pic
    }()
    
    lazy var video: FeedListViewCell_Video = {
        let video = FeedListViewCell_Video()
        video.cell = self
        return video
    }()
    
    lazy var web: FeedListViewCell_Web = {
        let web = FeedListViewCell_Web()
        return web
    }()
    
    lazy var timeL: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor(hexString: "#747474")
        return label
    }()
}


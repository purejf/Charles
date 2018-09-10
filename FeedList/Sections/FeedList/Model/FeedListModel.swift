//
//  FeedListModel.swift
//  FeedList
//
//  Created by y on 2018/9/7.
//  Copyright © 2018年 Charles. All rights reserved.
//

import UIKit

enum FeedListModelType: Int {
    case None = 0,
    Pic,
    Video,
    Web
}

class FeedListModel: NSObject {
    
    @objc var icon: String?
    @objc var name: String?
    @objc var content: String?
    
    var type: Int = 0
    
    @objc var images: [String]?
    
    @objc var videoCover: String?
    @objc var videoUrl: String?
    
    @objc var webIcon: String?
    @objc var webUrl: String?
    @objc var webTitle: String?
    
    @objc var location: String?
    @objc var time: String?
}

//
//  UIView+Add.swift
//  FeedList
//
//  Created by y on 2018/9/10.
//  Copyright © 2018年 Charles. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UITableViewCell

extension UITableViewCell {
    
    open class var identifier: String {
        get {
            return NSStringFromClass(self) + "cellId"
        }
    }
    open class var nibIdentifier: String {
        get {
            return NSStringFromClass(self) + "nibCellId"
        }
    }
    
    
    open class func cellWithTableView(_ tableView: UITableView) -> UITableViewCell {
        tableView.register(self, forCellReuseIdentifier: self.identifier)
        return tableView.dequeueReusableCell(withIdentifier: self.identifier)!
    }
    open class func nibCellWithTableView(_ tableView: UITableView) -> UITableViewCell {
        let nib = UINib(nibName: NSStringFromClass(self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: self.nibIdentifier)
        return tableView.dequeueReusableCell(withIdentifier: self.nibIdentifier)!
    }
}

// MARK: - UIView

extension UIView {
    
    // top
    @objc var top_: CGFloat {
        set {
            var rect = frame
            rect.origin.y = top_
            frame = rect
        }
        get {
            return frame.origin.y
        }
    }
    
    // left
    @objc var left_: CGFloat {
        set {
            var rect = frame
            rect.origin.x = left_
            frame = rect
        }
        get {
            return frame.origin.x
        }
    }
    
    // bottom
    @objc var bottom_: CGFloat {
        set {
            var rect = frame
            rect.origin.y = bottom_ - rect.height
            frame = rect
        }
        get {
            return frame.origin.y + frame.height
        }
    }
    
    // right
    @objc var right_: CGFloat {
        set {
            var rect = frame
            rect.origin.x = right_ - rect.width
            frame = rect
        }
        get {
            return frame.origin.x + frame.width
        }
    }
    
    // width
    @objc var width_: CGFloat {
        set {
            var rect = frame
            rect.size.width = width_
            frame = rect
        }
        get {
            return bounds.width
        }
    }
    
    // height
    @objc var height_: CGFloat {
        set {
            var rect = frame
            rect.size.height = height_
            frame = rect
        }
        get {
            return bounds.height
        }
    }
    
    // centerX
    @objc var centerX_: CGFloat {
        set {
            var center_ = center
            center_.x = centerX_
            center = center_
        }
        get {
            return center.x
        }
    }
    
    // centerY
    @objc var centerY_: CGFloat {
        set {
            var center_ = center
            center_.y = centerY_
            center = center_
        }
        get {
            return center.y
        }
    }
    
    // size
    @objc var size_: CGSize {
        set {
            var rect = frame
            rect.size = size_
            frame = rect
        }
        get {
            return bounds.size
        }
    }
    
}

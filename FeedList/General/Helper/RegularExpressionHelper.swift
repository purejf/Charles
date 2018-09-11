//
//  RegularExpressionHelper.swift
//  FeedList
//
//  Created by y on 2018/9/11.
//  Copyright © 2018年 Charles. All rights reserved.
//

import UIKit

class RegularExpressionHelper: NSObject {
    
    class func httpRegular() -> NSRegularExpression? {
        let regular = "((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"
        var expression: NSRegularExpression?
        do {
            try expression = NSRegularExpression(pattern: regular, options: NSRegularExpression.Options.caseInsensitive)
        } catch {
        }
        return expression
    }
    
    class func topicRegular() -> NSRegularExpression? {
        let regular = "#[^@#]+?#" 
        var expression: NSRegularExpression?
        do {
            try expression = NSRegularExpression(pattern: regular, options: NSRegularExpression.Options.caseInsensitive)
        } catch {
        }
        return expression
    }
}

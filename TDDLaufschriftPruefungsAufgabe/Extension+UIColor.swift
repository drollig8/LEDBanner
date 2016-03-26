//
//  Extension+UIColor.swift
//  ToDo
//
//  Created by Marc Felden on 12.03.16.
//  Copyright © 2016 Dominik Hauser. All rights reserved.
//

import UIKit

extension UIColor {

    class func iKVBDisplayDigitOn()-> UIColor {
        return UIColor(red: 255/255, green: 206/255, blue: 109/255, alpha: 1.0)
    }
    class func iKVBDisplayDigitOff()-> UIColor {
        return UIColor(red: 60/255, green: 45/255, blue: 45/255, alpha: 1.0)
    }
}

func isIphone4() -> Bool {
    if UIScreen.mainScreen().bounds.height == 480 {
        return true
    }
    return false
}
func isIphone5() -> Bool {
    if UIScreen.mainScreen().bounds.height == 568 {
        return true
    }
    return false
}
func isIphone6() -> Bool {
    if UIScreen.mainScreen().bounds.height == 667 {
        return true
    }
    return false
}
func isIphone6Plus() -> Bool {
    if UIScreen.mainScreen().bounds.height == 736 {
        return true
    }
    return false
}

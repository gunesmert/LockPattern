//
//  UIColorAdditions.swift
//  LockPattern
//
//  Created by gunesmert on 04/05/16.
//
//

import UIKit
import SwiftHEXColors

extension UIColor {
    public class func darkJungleGreenColor() -> UIColor {
        struct CachedColor { static var color :UIColor? = nil }
        
        guard let color = CachedColor.color else {
            let newColor = UIColor(hexString: "#1D1D1D")!
            
            CachedColor.color = newColor
            
            return newColor
        }
        
        return color
    }
    
    public class func ironColor() -> UIColor {
        struct CachedColor { static var color :UIColor? = nil }
        
        guard let color = CachedColor.color else {
            let newColor = UIColor(hexString: "#D8D8D8")!
            
            CachedColor.color = newColor
            
            return newColor
        }
        
        return color
    }
    
    public class func fireEngineRedColor() -> UIColor {
        struct CachedColor { static var color :UIColor? = nil }
        
        guard let color = CachedColor.color else {
            let newColor = UIColor(hexString: "#D32535")!
            
            CachedColor.color = newColor
            
            return newColor
        }
        
        return color
    }
    
    public class func caribbeanGreenColor() -> UIColor {
        struct CachedColor { static var color :UIColor? = nil }
        
        guard let color = CachedColor.color else {
            let newColor = UIColor(hexString: "#20D5B4")!
            
            CachedColor.color = newColor
            
            return newColor
        }
        
        return color
    }
    
    public class func pictonBlueColor() -> UIColor {
        struct CachedColor { static var color :UIColor? = nil }
        
        guard let color = CachedColor.color else {
            let newColor = UIColor(hexString: "#49A7FD")!
            
            CachedColor.color = newColor
            
            return newColor
        }
        
        return color
    }
}

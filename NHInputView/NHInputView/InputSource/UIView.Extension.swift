//
//  Coords.swift
//  NHInputView
//
//  Created by ninh nam on 4/28/20.
//  Copyright © 2020 ninh nam. All rights reserved.
//

import UIKit

extension UIView
{
    
    var left:CGFloat
        {
        set(x)
        {
            var frame:CGRect=self.frame
            frame.origin.x=round(x)
            self.frame=frame
        }
        get
        {
            return self.frame.origin.x
        }
    }
    
    
    var top:CGFloat
        {
        set(y)
        {
            var frame:CGRect=self.frame
            frame.origin.y=round(y)
            self.frame=frame
        }
        get
        {
            return self.frame.origin.y
        }
    }
    
    
    var width:CGFloat
        {
        set(width)
        {
            var frame:CGRect=self.frame
            frame.size.width = round(width)
            self.frame = frame
        }
        get
        {
            return self.frame.size.width
        }
    }
    
    var height:CGFloat
        {
        set(height)
        {
            var frame:CGRect=self.frame
            frame.size.height = round(height)
            self.frame = frame
        }
        get
        {
            return self.frame.size.height
        }
    }
    
    var right:CGFloat
        {
        set(right)
        {
            var frame:CGRect=self.frame
            frame.origin.x = round(right-self.width)
            self.frame = frame
        }
        get
        {
            return self.frame.origin.x + self.frame.size.width
        }
    }
    
    
    var bottom:CGFloat
        {
        set(bottom)
        {
            var frame:CGRect=self.frame
            frame.origin.y = round(bottom-self.height)
            self.frame = frame
        }
        get
        {
            return self.frame.origin.y + self.frame.size.height
        }
    }
    
}

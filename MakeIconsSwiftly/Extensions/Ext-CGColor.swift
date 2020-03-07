//
//  Ext-CGColor.swift
//  Make Icons Swiftly
//
//  Created by Marcy Vernon on 2/6/20.
//  Copyright © 2020 Marcy Vernon. All rights reserved.
//

import Foundation

extension CGColor {
    
    static var random: CGColor {
        
        return CGColor(red   : CGFloat.random(in: 0...255) / 255.0,
                       green : CGFloat.random(in: 0...255) / 255.0,
                       blue  : CGFloat.random(in: 0...255) / 255.0,
                       alpha : 1.0)
    }
    
    static var randomLight: CGColor {
        
        return CGColor(red   : CGFloat.random(in: 127...255) / 255.0,
                       green : CGFloat.random(in: 127...255) / 255.0,
                       blue  : CGFloat.random(in: 127...255) / 255.0,
                       alpha : 1.0)
    }
    
    static var randomDark: CGColor {
        
        return CGColor(red   : CGFloat.random(in: 0...127) / 255.0,
                       green : CGFloat.random(in: 0...127) / 255.0,
                       blue  : CGFloat.random(in: 0...127) / 255.0,
                       alpha : 1.0)
    }
    
    static var randomMedium: CGColor {
        
        return CGColor(red   : CGFloat.random(in: 77...177) / 255.0,
                       green : CGFloat.random(in: 77...177) / 255.0,
                       blue  : CGFloat.random(in: 77...177) / 255.0,
                       alpha : 1.0)
    }
}

//
//  Ext-Textfield.swift
//  Make Icons Swiftly
//
//  Created by Marcy Vernon on 1/31/20.
//  Copyright © 2020 Marcy Vernon. All rights reserved.
//

import AppKit

extension NSTextField {
    
    func setLabelSettings() {
        self.isEditable         = false
        self.isSelectable       = false
        self.textColor          = .labelColor
        self.backgroundColor    = .controlColor
        self.drawsBackground    = false
        self.isBezeled          = false
        self.alignment          = .natural
        self.font               = NSFont.systemFont(ofSize : NSFont.systemFontSize(for : self.controlSize))
        self.lineBreakMode      = .byClipping
        self.cell?.isScrollable = false
        self.cell?.wraps        = false
    }
    
    func setNormal() {
        self.stringValue = ""
        self.textColor   = .black
    }
    
    func warnUser(_ message: String, type: WarningType) {
        self.stringValue = message
        self.textColor = type == .info ? .black : #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    }
}

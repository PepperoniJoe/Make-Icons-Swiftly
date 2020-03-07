//
//  Ext-NSView.swift
//  Make Icons Swiftly
//
//  Created by Marcy Vernon on 2/2/20.
//  Copyright © 2020 Marcy Vernon. All rights reserved.
//
import AppKit

extension NSView {
    // Create ability to add background color for View that contains main message label.
    var bgColor: NSColor? {
        get {
            guard let color = layer?.backgroundColor else { return nil }
            return NSColor(cgColor: color)
        }
        set {
            wantsLayer = true
            layer?.backgroundColor = newValue?.cgColor
        }
    }
}




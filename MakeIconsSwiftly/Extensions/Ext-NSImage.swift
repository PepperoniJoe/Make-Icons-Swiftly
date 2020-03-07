//
//  Ext-NSImage.swift
//  Make Icons Swiftly
//
//  Created by Marcy Vernon on 1/29/20.
//  Copyright © 2020 Marcy Vernon. All rights reserved.
//

import AppKit

extension NSImage {
            
    //MARK: Resize image
    func resize(_ width: CGFloat, _ height: CGFloat) -> NSImage {
        
        let image = NSImage(size : CGSize(width: width, height: height))
        image.lockFocus()
        
        let context = NSGraphicsContext.current
        context?.imageInterpolation = .high
        let oldRect = NSMakeRect(0, 0, size.width, size.height)
        let newRect = NSMakeRect(0, 0, width, height)
        
        self.draw(in        : newRect,
                  from      : oldRect,
                  operation : .copy,
                  fraction  : 1)
        
        image.unlockFocus()
        
        return image
    }
    
    //MARK: - Save new image
    func save(_ path: String) -> Bool {
        guard let url = URL(string: path) else { return false }
        
        do {
            try pngData?.write(to: url, options: .atomic)
            return true
        } catch {
            print("✋🏻", error.localizedDescription)
            return false
        }
    }
    
    //MARK: - Checks for valid PNG image
    private var pngData: Data? {
        guard let tiffRepresentation = tiffRepresentation, let bitmapImage = NSBitmapImageRep(data: tiffRepresentation) else { return nil }
        return bitmapImage.representation(using: .png, properties: [:])
    }
}  // end of extension


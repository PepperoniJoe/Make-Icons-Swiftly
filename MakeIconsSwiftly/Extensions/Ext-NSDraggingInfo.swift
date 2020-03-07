//
//  Ext-NSDraggingInfo.swift
//  Make Icons Swiftly
//
//  Created by Marcy Vernon on 2/2/20.
//  Copyright © 2020 Marcy Vernon. All rights reserved.
//

import AppKit

extension NSDraggingInfo {
    
    var filePathURLs: [URL] {
        var filenames : [String]?
        var urls: [URL] = []
        
        filenames = draggingPasteboard.propertyList(forType: NSPasteboard.PasteboardType("NSFilenamesPboardType")) as? [String]
        
        if let filenames = filenames {
            for filename in filenames {
                urls.append(URL(fileURLWithPath: filename))
            }
            return urls
        }
        return []
    }
}


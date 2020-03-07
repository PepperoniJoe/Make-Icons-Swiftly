//
//  Ext-NSOpenPanel.swift
//  Make Icons Swiftly
//
//  Created by Marcy Vernon on 1/30/20.
//  Copyright © 2020 Marcy Vernon. All rights reserved.
//
import AppKit

extension NSOpenPanel {
    var selectFile: URL? {
        prompt                  = Prompt.useImage.rawValue
        allowsMultipleSelection = false
        canChooseDirectories    = false
        canChooseFiles          = true
        canCreateDirectories    = false
        allowedFileTypes        = Con.fileExtensions
        return runModal() == .OK ? urls.first : nil
    }
    
    var selectDirectory: URL? {
        prompt                  = Prompt.save.rawValue
        allowsMultipleSelection = true
        canChooseDirectories    = true
        canChooseFiles          = false
        canCreateDirectories    = true
        return runModal() == .OK ? urls.first : nil
    }
    
    var viewDirectory: URL? {
        prompt                  = Prompt.done.rawValue
        allowsMultipleSelection = true
        canChooseDirectories    = true
        canChooseFiles          = true
        canCreateDirectories    = true
        return runModal() == .OK ? urls.first : nil
    }
}

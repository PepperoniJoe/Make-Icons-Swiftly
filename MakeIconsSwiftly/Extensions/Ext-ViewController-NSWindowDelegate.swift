//
//  Ext-ViewController-NSWindowDelegate.swift
//  Make Icons Swiftly
//
//  Created by Marcy Vernon on 2/9/20.
//  Copyright © 2020 Marcy Vernon. All rights reserved.
//

import AppKit

////MARK: - NSWindowDelegate Extension
extension ViewController: NSWindowDelegate {
    
    override func viewDidAppear() {
        view.window?.delegate = self
        view.window?.contentMaxSize = shrinkSize
        resizeFrame(size: shrinkSize)
    }
    
    func windowWillClose(_ notification: Notification) {
        NSApplication.shared.terminate(self)
    }
}

//
//  WindowController.swift
//  Make Icons Swiftly
//
//  Created by Marcy Vernon on 1/29/20.
//  Copyright © 2020 Marcy Vernon. All rights reserved.
//

import AppKit

class WindowController: NSWindowController {
   
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    //Quit menu
    @IBAction func exit(sender: AnyObject) {
        NSApplication.shared.terminate(self)
    }
}

//
//  HelpViewController.swift
//  Make Icons Swiftly
//
//  Created by Marcy Vernon on 1/30/20.
//  Copyright © 2020 Marcy Vernon. All rights reserved.
//

import AppKit

class HelpViewController: NSViewController {
    
    @IBOutlet weak var helpScrollView : NSScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Start scrolling at top of document
        helpScrollView.contentView.scroll(NSPoint(x: helpScrollView.frame.size.height, y: 0))
    }
}
  

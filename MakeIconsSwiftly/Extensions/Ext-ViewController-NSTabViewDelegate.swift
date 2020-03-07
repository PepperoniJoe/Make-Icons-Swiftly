//
//  Ext-ViewController-NSTabViewDelegate.swift
//  Make Icons Swiftly
//
//  Created by Marcy Vernon on 2/14/20.
//  Copyright © 2020 Marcy Vernon. All rights reserved.
//

import AppKit

//MARK: - Extension NSTabViewDelegate
extension ViewController: NSTabViewDelegate {
    
    func tabView(_ tabView: NSTabView, didSelect tabViewItem: NSTabViewItem?) {

        guard let tab = tabViewItem else { return }

        if tab.label == "Icons" {
            tabSwitch = .icons
            checkAllOptionsOff()
            labelWarning.setNormal()
            buttonCreateFiles.isEnabled = isValidImage(image)
        } else {
            tabSwitch = .images
            checkAllImageOptionsOff()
            labelWarning.setNormal()
            imgButtonCreateFiles.isEnabled = isValidImg(image)
        }
    }
}

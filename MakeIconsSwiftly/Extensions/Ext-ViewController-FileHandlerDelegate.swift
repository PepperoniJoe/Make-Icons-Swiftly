//
//  Ext-ViewController-FileHandlerDelegate.swift
//  Make Icons Swiftly
//
//  Created by Marcy Vernon on 2/9/20.
//  Copyright © 2020 Marcy Vernon. All rights reserved.
//

import Foundation

//MARK: - FileHandleDelegate Extension
extension ViewController: FileHandlerDelegate {
    
    func getDeviceType() -> Device {
        
        var device: Device = .unknown
        let options = (checkboxIPhone.state,
                       checkboxIPad.state,
                       checkboxCarplay.state,
                       checkboxMac.state,
                       checkboxWatch.state)
        
        switch options {
            case (.on, .off, .off, _, _) : device = .iphone
            case (.off, .on, .off, _, _) : device = .ipad
            case (.off, .off, .on, _, _) : device = .carplay
            case (.on, .on, .off, _, _)  : device = .universal
            case (.on, .off, .on, _, _)  : device = .iphone_carplay
            case (.off, .on, .on, _, _)  : device = .ipad_carplay
            case (.on, .on, .on, _, _)   : device = .uni_carplay
            case (_, _, _, .on, _)       : device = .mac
            case (_, _, _, _, .on)       : device = .watch
            default                      : device = .unknown
        }
        return device
    }
    
    func sendMessage(message: String, type: WarningType) {
        labelWarning.warnUser(message, type: type)
    }
}

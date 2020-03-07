//
//  Ext-Date.swift
//  Make Icons Swiftly
//
//  Created by Marcy Vernon on 2/8/20.
//  Copyright © 2020 Marcy Vernon. All rights reserved.
//

import Foundation

extension Date {

    var timeStamp: Int {
        Int(self.timeIntervalSince1970)
    }
}


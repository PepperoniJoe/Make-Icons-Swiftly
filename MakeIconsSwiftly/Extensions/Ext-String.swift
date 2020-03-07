//
//  Ext-String.swift
//  Make Icons Swiftly
//
//  Created by Marcy Vernon on 2/19/20.
//  Copyright © 2020 Marcy Vernon. All rights reserved.
//

import Foundation

// Allows to have multiple errors expressed as a string.

extension String: Error, LocalizedError {
    public var errorDescription: String? { return self }
}

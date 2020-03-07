//
//  JSONModel.swift
//  Make Icons Swiftly
//
//  Created by Marcy Vernon on 2/15/20.
//  Copyright © 2020 Marcy Vernon. All rights reserved.
//

import Foundation

struct Contents: Codable {
    var images : [SingleImage]
    var info   : Info
}

struct SingleImage: Codable {
    var size     : String
    var idiom    : String
    var filename : String
    var scale    : String
}

struct Info: Codable {
    var version : Int
    var author  : String
}


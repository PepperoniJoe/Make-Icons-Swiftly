//
//  Enumerations.swift
//  Make Icons Swiftly
//
//  Created by Marcy Vernon on 2/2/20.
//  Copyright © 2020 Marcy Vernon. All rights reserved.
//

import Foundation

enum Tabs: String {
    case icons
    case images
}

// File manager dialogs
enum Prompt : String {
    case useImage = "Use Image"
    case save     = "Save Here"
    case done     = "Done"
}

// Type of message to send to user
enum WarningType : String {
    case error
    case info
}

enum Message: String, Error {
    case tooSmall         = "Source image should be 1024x1024 or greater. "
    case notSquare        = "Image is not square."
    case dragOrSelect     = "ICONS: Drop image OR choose from directory. Use 1024x1024 image."
    case imageSet         = "IMAGE SET: Provide 3x image."
    case oneFileOnly      = "Please drag one file only."
    case invalidFileType  = "File type must be png, jpg, gif or tiff format."
    case completed        = "Success: Files were created."
    case failed           = "Failure: Files were not created."
    case directoryExists  = "Directory already exists."
    case dirDoesNotExist  = "Directory does not exist."
    case directoryCreated = "Directory successfully created."
    case fileCreated      = "File successfully created."
    case fileDoesNotExist = "File does not exist."
    case fileDeleted      = "File deleted."
    case folderNotCreated = "Unable to create new folder with the image's name."
    case copied           = "Item copied."
    case fileManagerError = "A file error occurred"
    case needOption       = "Select an option."
    case easterEgg        = "Use the randomly-generated image to create placeholder icons."
    case normal           = ""
}

enum ToolTip: String {
    case iphone     = "Create icons for iPhone apps."
    case ipad       = "Create icons for iPad apps."
    case carplay    = "Create icons for Car Play."
    case mac        = "Create icons for Mac apps."
    case watch      = "Create icons for Apple Watch."
    case assets     = "Create a complete Assets Catalog including icon set with images."
    case iconSet    = "Create an icon set with images."
    case imagesOnly = "Create images without the icon set or catalog."
    case folder     = "Place result files in a folder named after the image."
    case slider     = "Change size of image."
    case imgUni     = "Create image for multiple resolutions."
    case imgIphone  = "Create images for iPhone resolutions."
    case imgIpad    = "Create images for iPad resolutions."
    case imgCarplay = "Create images for Car Play resolutions."
    case imgMac     = "Create images for Mac resolutions."
    case imgWatch   = "Create images for Apple Watch resolutions."
    case imgAppleTV = "Create images for Apple TV resolutions."
    case imgCatalog = "Create a complete Image Catalog including image set."
    case imageSet   = "Create an image set named after the source image."
    case imgOnly    = "Create images without the image set or catalog."
}

// File management Components
enum File: String {
    case assetsCatalog = "Assets.xcassets"
    case iconSet       = "AppIcon.appiconset"
    case imageCatalog  = "Images.xcassets"
    case imageSet      = ".imageset"
    case json
    case contents      = "Contents"
    case contentsJSON  = "Contents.json"
    case prefix        = "Contents_"
    case author        = "Make Icons Swiftly"
    case imagename     = "ImageName"
}

// Icon sets needed for these device combos. Corresponds to the Data.swift file
enum Device: String {
    case iphone
    case ipad
    case carplay = "car"
    case universal
    case uni_carplay = "uni_car"
    case iphone_carplay = "iphone_car"
    case ipad_carplay = "ipad_car"
    case mac
    case watch
    case tv
    case unknown
}

// UI selections to be saved
enum Key : String {
    case iphone    = "iPhone"
    case ipad      = "iPad"
    case carplay   = "Carplay"
    case mac       = "Mac"
    case watch     = "Watch"
    case assets    = "Assets"
    case iconSet   = "IconSet"
    case imageOnly = "ImageOnly"
    case imageURL
    case saveURL
    case slider
    case folder
    case imgUni     = "imgUni"
    case imgIphone  = "imgIPhone"
    case imgIpad    = "imgIPad"
    case imgCarplay = "imgCarplay"
    case imgMac     = "imgMac"
    case imgWatch   = "imgWatch"
    case imgAppleTV = "imgApplTV"
    case imgCatalog = "imgCatalog"
    case imageSet   = "imageSet"
    case imgOnly    = "imgOnly"
    case imgFolder  = "imgFolder"
}

enum Shape {
    case square
    case circle
}



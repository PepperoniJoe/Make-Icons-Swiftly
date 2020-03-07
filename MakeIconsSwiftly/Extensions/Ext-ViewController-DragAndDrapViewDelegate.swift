//
//  Ext-ViewController-DragAndDrapViewDelegate.swift
//  Make Icons Swiftly
//
//  Created by Marcy Vernon on 2/9/20.
//  Copyright © 2020 Marcy Vernon. All rights reserved.
//

import Foundation

//MARK: - DragAndDropViewDelegate  Extension
extension ViewController: DragAndDropViewDelegate {
    
    func dragAndDrop(_ dragAndDropView: DragAndDropView, droppedFileWithURL url: URL) {
        // Get folder name from image name
        let updatedURL    = url
        let urlWithoutExt = updatedURL.deletingPathExtension()
        fileName          = urlWithoutExt.lastPathComponent
        
        // Get image and validate it
        getImage(url)

        checkValidImage()
        tabSwitch == .icons ? checkAllOptionsOff() : checkAllImageOptionsOff()
    }
    
    func dragAndDrop(_ dragAndDropView: DragAndDropView, droppedFilesWithURLs urls: [URL]) {
        labelWarning.warnUser(Message.oneFileOnly.rawValue, type: .error)
    }
    
    func dragAndDrop(_ dragAndDropView: DragAndDropView, isValidFileType: Bool) {
        labelWarning.warnUser(Message.invalidFileType.rawValue, type: .error)
    }
}

//
//  DragAndDropView.swift
//  Make Icons Swiftly
//
//  Created by Marcy Vernon on 2/2/20.
//  Copyright © 2020 Marcy Vernon. All rights reserved.
//

import AppKit

class DragAndDropView: NSView {
    
    private var isValidFileType = false
    
    var acceptedFileExtensions: [String] = []
    
    weak var delegate: DragAndDropViewDelegate?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        registerForDraggedTypes([NSPasteboard.PasteboardType.fileURL])
    }
    
    // MARK: - Dragging Entered
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        isValidFileType = isExtensionAcceptable(draggingInfo: sender)
        
        if isValidFileType == false {
            delegate?.dragAndDrop(self, isValidFileType: false)
        }
        return []
    }
    
    
    // MARK: - File reached Drag destination
    override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
        return isValidFileType ? .copy : []
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        
        guard sender.filePathURLs.count > 0 else { return false}
        
        if isValidFileType {
            sender.filePathURLs.count == 1 ? delegate?.dragAndDrop(self, droppedFileWithURL: sender.filePathURLs.first!)
                                           : delegate?.dragAndDrop(self, droppedFilesWithURLs: sender.filePathURLs)
            return true
        }
        return false
    }
    
    private func isExtensionAcceptable(draggingInfo: NSDraggingInfo) -> Bool {
        guard draggingInfo.filePathURLs.count > 0  else { return false }
        
        for filePathURL in draggingInfo.filePathURLs {
            let fileExtension = filePathURL.pathExtension.lowercased()
            
            if acceptedFileExtensions.contains(fileExtension) == false {
                return false
            }
        }
        return true
    }
    
    override func acceptsFirstMouse(for event: NSEvent?) -> Bool {
        return true
    }
} // end of DragAndDropView

//MARK: - Drag and Drop Protocol
protocol DragAndDropViewDelegate: class {
    func dragAndDrop(_ dragAndDropView: DragAndDropView, droppedFileWithURL  url: URL)
    func dragAndDrop(_ dragAndDropView: DragAndDropView, droppedFilesWithURLs urls: [URL])
    func dragAndDrop(_ dragAndDropView: DragAndDropView, isValidFileType: Bool)
}


//
//  FileHandler.swift
//  Make Icons Swiftly
//
//  Created by Marcy Vernon on 1/29/20.
//  Copyright © 2020 Marcy Vernon. All rights reserved.
//

import AppKit

protocol FileHandlerDelegate {
    var image                : NSImage? { get set }
    var fileName             : String { get }
    func sendMessage(message : String, type : WarningType)
    func getDeviceType() -> Device
}

struct FileHandler {
    var delegate: FileHandlerDelegate?
    var device: Device = .unknown
    
     //MARK: - Create a Folder name using the image file name
     func createNamedFolder(_ url: URL, name: String) -> URL? {

         let response: FileManagerResponse = createDirectory(url, name: name)
         
         if let url = response.url {
             return url
         } else {
            delegate?.sendMessage(message: response.error ?? Message.folderNotCreated.rawValue, type: .error)
             return nil
         }
     }
    
    //MARK: -                                       --  I C O N S  --
    //MARK: - Create the Asset Catalog (for Icons)
    mutating func createAssetsCatalog(_ url: URL) {
        
        let response: FileManagerResponse = createDirectory(url, name: File.assetsCatalog.rawValue)
        
        if let url = response.url {
            copyFile(url: url, newName: File.contentsJSON.rawValue, sourceFile: File.contents.rawValue, sourceExt: File.json.rawValue)
            createIconSet(url)
        } else {
            delegate?.sendMessage(message: response.error ?? Message.fileManagerError.rawValue, type: .error)
        }
    }

     
     //MARK: - Create the Icon Set
    mutating func createIconSet(_ url: URL) {
        
         let response: FileManagerResponse = createDirectory(url, name: File.iconSet.rawValue)
         device = delegate?.getDeviceType() ?? Device.unknown
        
         let resource = File.prefix.rawValue + device.rawValue

         if let url = response.url {
            copyFile(url: url, newName: File.contentsJSON.rawValue, sourceFile: resource, sourceExt: File.json.rawValue)
             createIcons(url)
         } else {
            delegate?.sendMessage(message: response.error ?? Message.fileManagerError.rawValue, type: .error)
         }
     }
 
    
    //MARK: - Create multiple size icons and save
    mutating func createIcons(_ url: URL) {
        
        device = delegate?.getDeviceType() ?? Device.unknown
        
        if let image = delegate?.image {
            if saveIcons(image: image, path: url.absoluteString, device: device) {
            } else {
                delegate?.sendMessage(message: Message.failed.rawValue, type: .error)
            }
        }
    }
    
    
    //MARK: - Save Icons
    func saveIcons(image: NSImage, path: String, device: Device) -> Bool {
        guard let dataArray = data[device.rawValue] else { return false }
        
        var didFilesSave = [Bool]()
        
        DispatchQueue.main.async {
            for meta in dataArray {
                let newImage = image.resize(meta.width, meta.height)
                didFilesSave.append( newImage.save(path + meta.filename))
            }
        }
        return  Set(didFilesSave).contains(false) ? false : true
    }
    
        //MARK: -                                       --  I M A G E S  --
     //MARK: - Create the Image Catalog
    mutating func createImageCatalog(_ url: URL, optionList: [String], sourceSize: CGSize) {

         let response: FileManagerResponse = createDirectory(url, name: File.imageCatalog.rawValue)
         
         if let url = response.url {
            createImageSet(url, optionList: optionList, sourceSize: sourceSize)
         } else {
            delegate?.sendMessage(message: response.error ?? Message.fileManagerError.rawValue, type: .error)
         }
     }

    
     //MARK: - Create the Image Set
    mutating func createImageSet(_ url: URL, optionList: [String], sourceSize: CGSize) {

        let imageName = delegate?.fileName ?? File.imagename.rawValue
         let name = "\(imageName)\(File.imageSet.rawValue)"
         let response: FileManagerResponse = createDirectory(url, name: name)
         
         if let url = response.url {
            generateContentsFile(url: url, optionList: optionList, sourceSize: sourceSize)
            createImages(url, optionList: optionList, sourceSize: sourceSize)
         } else {
            delegate?.sendMessage(message: response.error ?? Message.fileManagerError.rawValue, type: .error)
         }
     }
     
    
    //MARK: - Creates JSON Content file for the 1x2x3x images.
    func generateContentsFile(url: URL, optionList: [String], sourceSize: CGSize) {
        
        let info   = Info(version: 1, author: File.author.rawValue)
        var images = [SingleImage]()
        let size   = getOneThirdSize(sourceSize)
        let wThird = size.width
        let hThird = size.height
        
        for option in optionList {
            if let resolution = resolution[option] {
                for scale in resolution {
                    let contentSize     = "\(wThird)x\(hThird)"
                    let contentFileName = "\(option)_\(contentSize)@\(scale)x.png"
                    images.append(SingleImage(size : contentSize, idiom: option, filename: contentFileName, scale: "\(scale)x" ))
                }
            }
        }
        
        let contents = Contents(images: images, info: info)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        if let data = try? encoder.encode(contents) {
            let newURL = url.appendingPathComponent(File.contentsJSON.rawValue)

            do {
                try data.write(to: newURL, options: .atomic)
            } catch {
                print("✋🏻", error)
            }
        }
    }
    
    func getOneThirdSize(_ size: CGSize) -> Size {
        return (Int(size.width.divideBy(3)), Int(size.height.divideBy(3)))
    }
    

    //MARK: - Create multiple size images and save
    mutating func createImages(_ url: URL, optionList: [String], sourceSize: CGSize) {
        
        if let image = delegate?.image {
            if saveImages(image: image, path: url.absoluteString, optionList: optionList, sourceSize: sourceSize) == true {
            } else {
                delegate?.sendMessage(message: Message.failed.rawValue, type: .error)
            }
        }
    }
    
    
    //MARK: - Save Images
    func saveImages(image: NSImage, path: String, optionList: [String], sourceSize: CGSize) -> Bool {

        var didFilesSave = [Bool]()
        let size         = getOneThirdSize(sourceSize)
        let wThird       = size.width
        let hThird       = size.height
        
        DispatchQueue.main.async {
            for option in optionList {
                if let resolution = resolution[option] {
                    for scale in resolution {
                        let contentSize     = "\(wThird)x\(hThird)"
                        let contentFileName = "\(option)_\(contentSize)@\(scale)x.png"
                        let newImage        = image.resize(CGFloat(wThird * scale), CGFloat(hThird * scale))
                        didFilesSave.append( newImage.save(path + contentFileName))
                    }
                }
            }
        }
        return  Set(didFilesSave).contains(false) ? false : true
    }
    
    
 //MARK: -                                  -- General functions --
    //MARK: - Create Directory
    func createDirectory(_ url: URL, name: String) -> FileManagerResponse {
        var itemURL = url
        itemURL.appendPathComponent(name, isDirectory: true)
        
        if doesDirectoryExist(itemURL.path) == true {
            return (itemURL, Message.directoryExists, nil)
        } else {
            do {
                try FileManager.default.createDirectory(at: itemURL, withIntermediateDirectories: false, attributes: nil)
                return (itemURL, Message.directoryCreated, nil )
            } catch {
                return (nil, Message.fileManagerError, error.localizedDescription)
            }
        }
    }
    
    //MARK: - Create Directory
    func viewDirectory(_ url: URL, name: String) -> FileManagerResponse {
        var itemURL = url
        itemURL.appendPathComponent(name, isDirectory: true)
        
        if doesDirectoryExist(itemURL.path) == true {
            do {
                try FileManager.default.contentsOfDirectory(atPath: itemURL.path)
                return (nil, Message.normal, nil)
            } catch {
                return (nil, Message.fileManagerError, error.localizedDescription)
            }
            
        } else {
            return (nil, Message.dirDoesNotExist, nil)
        }
    }
    
    
    //MARK: - Copy File
    func copyFile(url: URL, newName: String, sourceFile: String, sourceExt: String) {
        
        let file = url.appendingPathComponent(newName)
        
        if let source = Bundle.main.url(forResource: sourceFile, withExtension: sourceExt) {
            try? FileManager.default.removeItem(at: file) // Remove if exists
            try? FileManager.default.copyItem(at: source, to: file) // Create
        }
    }

    
    //MARK: - Boolean Checks
    func doesFileExist(_ path: String) -> Bool {
        return FileManager.default.fileExists(atPath: path) == true ? true : false
    }
    
    func doesDirectoryExist(_ path: String) -> Bool {
        var isFolder : ObjCBool = true
        return FileManager.default.fileExists(atPath: path, isDirectory: &isFolder) == true ? true : false
    }
    
} // end of FileHandler


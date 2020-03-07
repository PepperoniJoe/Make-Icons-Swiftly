//
//  ViewController.swift
//  Make Icons Swiftly
//
//  Created by Marcy Vernon on 1/28/20.
//  Copyright © 2020 Marcy Vernon. All rights reserved.
//

import AppKit

class ViewController: NSViewController {
    
    private let sourcePanel             = NSOpenPanel()
    private let destinationPanel        = NSOpenPanel()
    private let resultPanel             = NSOpenPanel()
    private var fileHandler             = FileHandler()
    private let easterEgg               = EasterEgg()
    private let tabView                 = TabView()
    private var optionList  : [String]  = []
    private var saveURL     : URL?      = nil
    
    internal let defaults               = UserDefaults.standard
    internal var fileName               = String()
    internal var image      : NSImage?  = nil
    internal let shrinkSize : CGSize    = CGSize(width : 400, height : 200)
    internal var tabSwitch  : Tabs      = .icons
    
    //MARK: - Header
    @IBOutlet weak var buttonLogo           : NSButton!
    @IBOutlet weak var labelWarning         : NSTextField!
    @IBOutlet weak var warningHolder        : NSView!
    
    //MARK: - Source Image
    @IBOutlet weak var labelTiny            : NSTextField!
    @IBOutlet weak var imageMain            : NSImageView!
    @IBOutlet weak var dragAndDropView      : DragAndDropView!
    @IBOutlet weak var constraintImageWidth : NSLayoutConstraint!
    @IBOutlet weak var sliderImageSize      : NSSlider!
    @IBOutlet weak var buttonSelectImage    : NSButton!
    
    //MARK: - ICONS
    @IBOutlet weak var checkboxIPhone       : NSButton!
    @IBOutlet weak var checkboxIPad         : NSButton!
    @IBOutlet weak var checkboxCarplay      : NSButton!
    @IBOutlet weak var checkboxMac          : NSButton!
    @IBOutlet weak var checkboxWatch        : NSButton!
    @IBOutlet weak var radioAssets          : NSButton!
    @IBOutlet weak var radioIconSet         : NSButton!
    @IBOutlet weak var radioImagesOnly      : NSButton!
    @IBOutlet weak var checkboxFolder       : NSButton!
    @IBOutlet weak var buttonCreateFiles    : NSButton!
    
    //MARK: - IMAGES
    @IBOutlet weak var imgCheckboxUni       : NSButton!
    @IBOutlet weak var imgCheckboxIPhone    : NSButton!
    @IBOutlet weak var imgCheckboxIPad      : NSButton!
    @IBOutlet weak var imgCheckboxCarplay   : NSButton!
    @IBOutlet weak var imgCheckboxMac       : NSButton!
    @IBOutlet weak var imgCheckboxWatch     : NSButton!
    @IBOutlet weak var imgCheckboxAppleTV   : NSButton!
    @IBOutlet weak var imgRadioCatalog      : NSButton!
    @IBOutlet weak var imgRadioImageSet     : NSButton!
    @IBOutlet weak var imgRadioImagesOnly   : NSButton!
    @IBOutlet weak var imgCheckboxFolder    : NSButton!
    @IBOutlet weak var imgButtonCreateFiles : NSButton!
    
    
    //MARK: - Initial Setup
    override func viewDidLoad() {
        
        //Tab View Control
        tabView.delegate = self as NSTabViewDelegate
        
        // Set up UI
        setToolTips()
        getPriorSettings()
        labelWarning.setLabelSettings()
        warningHolder.bgColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
        // Set up Drag and Drop
        dragAndDropView.delegate = self
        dragAndDropView.acceptedFileExtensions = Con.fileExtensions
        
        //Drag Box Resizing
        sliderImageSize.isContinuous = true
        
        // Validation
        checkAllOptionsOff()
        
        //File Management
        fileHandler.delegate = self
        
    }
    
    //MARK: - Validations
    
    func checkValidImage() {
        if tabSwitch == .icons {
            buttonCreateFiles.isEnabled = isValidImage(image)
        } else {
            imgButtonCreateFiles.isEnabled = isValidImg(image)
        }
    }
    
    //MARK: -                                          --  S O U R C E  I M A G E  --
    //MARK: - Get Image
    @IBAction func selectImage(_ sender: Any) {
        getImageFromDirectory()
        tabSwitch == .icons ? checkAllOptionsOff() : checkAllImageOptionsOff()
        checkValidImage()
    }
    
    private func getImageFromDirectory() {
        // Get directory of prior selected image
        if let savedValue = defaults.string(forKey: Key.imageURL.rawValue) {
            sourcePanel.directoryURL = URL(string: savedValue) ?? nil
        }
        
        //Select image
        if let url = sourcePanel.selectFile {
            fileName = url.deletingPathExtension().lastPathComponent
            defaults.set(url.absoluteString, forKey: Key.imageURL.rawValue)
            getImage(url)
        }
    }
    
    
    func getImage(_ url: URL) {
        guard let img = NSImage(contentsOf: url) else { return }
        image           = img
        imageMain.image = img
        displayImageSize(img.size)
    }
    
    private func displayImageSize(_ size: CGSize) {
        labelTiny.isHidden = false
        let width  = Int(size.width)
        let height = Int(size.height)
        labelTiny.stringValue = "Size: \(width) x \(height)"
    }
    
    
    //MARK: - Slider
    @IBAction func widenImage(_ sender: NSSlider) {
        //adjust the image size
        constraintImageWidth.constant = CGFloat(sender.doubleValue)
        defaults.set(constraintImageWidth.constant, forKey : Key.slider.rawValue)
        
        // Resize to remove excess window space.
        if Int(sender.doubleValue.rounded(.towardZero)) % 5 == 0 {  // cut UI jitter
            resizeFrame(size: shrinkSize)
        }
    }
    
    
    func resizeFrame(size: CGSize) {
        if let originalFrame = view.window?.frame {
            let newY = originalFrame.maxY - size.height
            view.window?.setFrame(NSRect(x: originalFrame.origin.x, y: newY, width: size.width, height: size.height), display: true, animate: false)
        }
    }
    
    //MARK: - Easter Egg
    @IBAction func generateRandomImage(_ sender: Any) {
        
        fileName = "Image\(Date().timeStamp)"
        image = easterEgg.createRandomImage()
        imageMain.image = image
        
        if let size = image?.size { displayImageSize(size) }
        labelWarning.warnUser(Message.easterEgg.rawValue, type: .info)
        checkValidImage()
        tabSwitch == .icons ? checkAllOptionsOff() : checkAllImageOptionsOff()
    }
    
    
    //MARK: -                                           --  I C O N S  S E T  --
    //MARK - Source image for icon set
    func isValidImage(_ image: NSImage?) -> Bool {
        
        do {
            try checkIconImage(image)
            return true
        } catch {
            labelWarning.warnUser(error.localizedDescription, type: .info)
            return false
        }
    }
    
    func checkIconImage(_ image: NSImage?) throws {
        var error = String()
        
        guard let image = image else {
            error = Message.dragOrSelect.rawValue // image missing
            throw error
        }
        
        if image.size.width < 1024 || image.size.height < 1024 { // image too small
            error += Message.tooSmall.rawValue
        }
        
        if image.size.width != image.size.height {  // image not square
            error += Message.notSquare.rawValue
        }
        
        if error.count > 0 {
            throw error
        }
    }
    
    //MARK: - Handle Icon Options Selection
    @IBAction func selectOption(_ sender: NSButton) {
        switch sender.tag {
            case 1  : checkIOSSwitches()
            case 2  : checkIOSSwitches()
            case 3  : checkIOSSwitches()
            case 4  : checkMacSwitch()
            case 5  : checkWatchSwitch()
            default : break
        }
        
        defaults.set(checkboxIPhone.state,  forKey : Key.iphone.rawValue)
        defaults.set(checkboxIPad.state,    forKey : Key.ipad.rawValue)
        defaults.set(checkboxCarplay.state, forKey : Key.carplay.rawValue)
        defaults.set(checkboxMac.state,     forKey : Key.mac.rawValue)
        defaults.set(checkboxWatch.state,   forKey : Key.watch.rawValue)
        
        checkAllOptionsOff()
    }
    
    func checkAllOptionsOff() {
        if checkboxIPhone.state   == .off &&
            checkboxIPad.state    == .off &&
            checkboxCarplay.state == .off &&
            checkboxMac.state     == .off &&
            checkboxWatch.state   == .off {
            buttonCreateFiles.isEnabled = false
            labelWarning.warnUser(Message.needOption.rawValue, type: .error)
        } else {
            labelWarning.setNormal()
            buttonCreateFiles.isEnabled = isValidImage(image)
        }
    }
    
    private func checkIOSSwitches() {
        if checkboxIPhone.state == .on || checkboxIPad.state == .on || checkboxCarplay.state == .on {
            checkboxMac.state   = .off
            checkboxWatch.state = .off
        }
    }
    
    private func checkMacSwitch() {
        if checkboxMac.state == .on {
            checkboxIPhone.state  = .off
            checkboxIPad.state    = .off
            checkboxCarplay.state = .off
            checkboxWatch.state   = .off
        }
    }
    
    private func checkWatchSwitch() {
        if checkboxWatch.state == .on {
            checkboxIPhone.state  = .off
            checkboxIPad.state    = .off
            checkboxCarplay.state = .off
            checkboxMac.state     = .off
        }
    }
    
    
    //MARK: - Handle Icon FileType Selection
    @IBAction func selectFileType(_ sender: NSButton) {
        switch sender.tag {
            case 1  : checkAssets()
            case 2  : checkIconSet()
            case 3  : checkImages()
            default : break
        }
        
        defaults.set(radioAssets.state,     forKey: Key.assets.rawValue)
        defaults.set(radioIconSet.state,    forKey: Key.iconSet.rawValue)
        defaults.set(radioImagesOnly.state, forKey: Key.imageOnly.rawValue)
    }
    
    // Icon File Types
    private func checkAssets() {
        if radioAssets.state == .on  {
            radioIconSet.state    = .off
            radioImagesOnly.state = .off
        }
    }
    
    private func checkIconSet() {
        if radioIconSet.state == .on  {
            radioAssets.state     = .off
            radioImagesOnly.state = .off
        }
    }
    
    private func checkImages() {
        if radioImagesOnly.state == .on  {
            radioAssets.state  = .off
            radioIconSet.state = .off
        }
    }
    
    
    //MARK: - Icon Creates Files
    @IBAction func createFiles(_ sender: Any) {
        
        labelWarning.setNormal()
        guard let url = getImageStartingURL() else { return }
        
        let fileTypes = (radioAssets.state, radioIconSet.state, radioImagesOnly.state)
        
        switch fileTypes {
            case (.on, .off, .off) : fileHandler.createAssetsCatalog(url)
            case (.off, .on, .off) : fileHandler.createIconSet(url)
            case (.off, .off, .on) : fileHandler.createIcons(url)
            default                : break
        }
        
        selectResultDirectory()
    }
    
    // Allow user to pic the destination directory. Create new folder if requested.
    private func getStartingURL() -> URL? {
        
        if let savedURL = selectDestinationDirectory() {
            if checkboxFolder.state == .on {
                return fileHandler.createNamedFolder(savedURL, name: fileName)
            }
            return savedURL
        }
        return nil
    }
    
    private func selectDestinationDirectory() -> URL? {
        // Get the destination Directory from prior time
        if let savedValue = defaults.string(forKey: Key.saveURL.rawValue) {
            destinationPanel.directoryURL = URL(string: savedValue) ?? nil
        }
        
        // Save the destination directory
        if let url = destinationPanel.selectDirectory {
            defaults.set(url.absoluteString, forKey: Key.saveURL.rawValue)
            return url
        }
        return nil
    }
    
    private func selectResultDirectory() {
        // Get the result Directory from save destination
        if let savedValue = defaults.string(forKey: Key.saveURL.rawValue) {
            resultPanel.directoryURL = URL(string: savedValue) ?? nil
        }
        
        let _ = resultPanel.viewDirectory
    }
    
    //MARK: - Handle Optional Settings Selection
    @IBAction func selectPlaceInFolder(_ sender: NSButton) {
        defaults.set(checkboxFolder.state, forKey: Key.folder.rawValue)
        defaults.set(imgCheckboxFolder.state, forKey: Key.imgFolder.rawValue)
    }
    
    //MARK: -                                          --  I M A G E  S E T  --
    //MARK: Source image for image set
    func isValidImg(_ image: NSImage?) -> Bool {
        
        if image == nil {
            labelWarning.warnUser(Message.imageSet.rawValue, type: .info)  // missing image
            return false
        }
        return true
    }
    
    
    //MARK: - Handle Image Options Selection
    @IBAction func selectImgOptions(_ sender: NSButton) {
        defaults.set(imgCheckboxUni.state,     forKey : Key.imgUni.rawValue)
        defaults.set(imgCheckboxIPhone.state,  forKey : Key.imgIphone.rawValue)
        defaults.set(imgCheckboxIPad.state,    forKey : Key.imgIpad.rawValue)
        defaults.set(imgCheckboxCarplay.state, forKey : Key.imgCarplay.rawValue)
        defaults.set(imgCheckboxMac.state,     forKey : Key.imgMac.rawValue)
        defaults.set(imgCheckboxWatch.state,   forKey : Key.imgWatch.rawValue)
        defaults.set(imgCheckboxAppleTV.state, forKey : Key.imgAppleTV.rawValue)
        
        checkAllImageOptionsOff()
    }
    
    func checkAllImageOptionsOff() {
        if imgCheckboxUni.state      == .off &&
            imgCheckboxIPhone.state  == .off &&
            imgCheckboxIPad.state    == .off &&
            imgCheckboxCarplay.state == .off &&
            imgCheckboxMac.state     == .off &&
            imgCheckboxWatch.state   == .off &&
            imgCheckboxAppleTV.state == .off {
            imgButtonCreateFiles.isEnabled = false
            labelWarning.warnUser(Message.needOption.rawValue, type: .error)
        } else {
            labelWarning.setNormal()
            buildImageOptionList()
            imgButtonCreateFiles.isEnabled = isValidImg(image)
        }
    }
    
    // Get all selected options for image sets
    private func buildImageOptionList() {
        
        optionList.removeAll()
        
        if imgCheckboxUni.state     == .on { optionList.append(Device.universal.rawValue) }
        if imgCheckboxIPhone.state  == .on { optionList.append(Device.iphone.rawValue) }
        if imgCheckboxIPad.state    == .on { optionList.append(Device.ipad.rawValue) }
        if imgCheckboxCarplay.state == .on { optionList.append(Device.carplay.rawValue) }
        if imgCheckboxMac.state     == .on { optionList.append(Device.mac.rawValue) }
        if imgCheckboxWatch.state   == .on { optionList.append(Device.watch.rawValue) }
        if imgCheckboxAppleTV.state == .on { optionList.append(Device.tv.rawValue) }
    }
    
    
    //MARK: - Handle Image FileType Selection
    @IBAction func selectImgFileType(_ sender: NSButton) {
        switch sender.tag {
            case 11 : checkCatalog()
            case 12 : checkImageSet()
            case 13 : checkImgOnly()
            default : break
        }
        
        defaults.set(imgRadioCatalog.state,    forKey: Key.imgCatalog.rawValue)
        defaults.set(imgRadioImageSet.state,   forKey: Key.imageSet.rawValue)
        defaults.set(imgRadioImagesOnly.state, forKey: Key.imgOnly.rawValue)
    }
    
    // Image File Types
    private func checkCatalog() {
        if imgRadioCatalog.state == .on  {
            imgRadioImageSet.state   = .off
            imgRadioImagesOnly.state = .off
        }
    }
    
    private func checkImageSet() {
        if imgRadioImageSet.state == .on  {
            imgRadioCatalog.state    = .off
            imgRadioImagesOnly.state = .off
        }
    }
    
    private func checkImgOnly() {
        if imgRadioImagesOnly.state == .on  {
            imgRadioCatalog.state  = .off
            imgRadioImageSet.state = .off
        }
    }
    
    
    //MARK: - Image Creates Files
    @IBAction func createImageFiles(_ sender: Any) {
        
        labelWarning.setNormal()
        guard let url = getImageStartingURL() else { return }
        guard let image = image else { return }
        
        let fileTypes = (imgRadioCatalog.state, imgRadioImageSet.state, imgRadioImagesOnly.state)
        
        switch fileTypes {
            case (.on, .off, .off) : fileHandler.createImageCatalog(url, optionList: optionList, sourceSize: image.size)
            case (.off, .on, .off) : fileHandler.createImageSet(url, optionList: optionList, sourceSize: image.size)
            case (.off, .off, .on) : fileHandler.createImages(url, optionList: optionList, sourceSize: image.size)
            default                : break
        }
        
        selectImageResultDirectory()
    }
    
    // Allow user to pic the destination directory. Create new folder if requested.
    private func getImageStartingURL() -> URL? {
        
        if let savedURL = selectImageDestinationDirectory() {
            if imgCheckboxFolder.state == .on {
                return fileHandler.createNamedFolder(savedURL, name: fileName)
            }
            return savedURL
        }
        return nil
    }
    
    private func selectImageDestinationDirectory() -> URL? {
        // Get the destination Directory from prior time
        if let savedValue = defaults.string(forKey: Key.saveURL.rawValue) {
            destinationPanel.directoryURL = URL(string: savedValue) ?? nil
        }
        
        // Save the destination directory
        if let url = destinationPanel.selectDirectory {
            defaults.set(url.absoluteString, forKey: Key.saveURL.rawValue)
            return url
        }
        return nil
    }
    
    private func selectImageResultDirectory() {
        // Get the result Directory from save destination
        if let savedValue = defaults.string(forKey: Key.saveURL.rawValue) {
            resultPanel.directoryURL = URL(string: savedValue) ?? nil
        }
        
        let _ = resultPanel.viewDirectory
    }
    
} // end of ViewController



//MARK: - Initial Setup Extension
private extension ViewController {
    
    private func setToolTips() {
        checkboxIPhone.toolTip     = ToolTip.iphone.rawValue
        checkboxIPad.toolTip       = ToolTip.ipad.rawValue
        checkboxCarplay.toolTip    = ToolTip.carplay.rawValue
        checkboxMac.toolTip        = ToolTip.mac.rawValue
        checkboxWatch.toolTip      = ToolTip.watch.rawValue
        radioAssets.toolTip        = ToolTip.assets.rawValue
        radioIconSet.toolTip       = ToolTip.iconSet.rawValue
        radioImagesOnly.toolTip    = ToolTip.imagesOnly.rawValue
        checkboxFolder.toolTip     = ToolTip.folder.rawValue
        sliderImageSize.toolTip    = ToolTip.slider.rawValue
        imgCheckboxUni.toolTip     = ToolTip.imgUni.rawValue
        imgCheckboxIPhone.toolTip  = ToolTip.imgIphone.rawValue
        imgCheckboxIPad.toolTip    = ToolTip.imgIpad.rawValue
        imgCheckboxCarplay.toolTip = ToolTip.imgCarplay.rawValue
        imgCheckboxMac.toolTip     = ToolTip.imgMac.rawValue
        imgCheckboxWatch.toolTip   = ToolTip.imgWatch.rawValue
        imgCheckboxAppleTV.toolTip = ToolTip.imgAppleTV.rawValue
        imgRadioCatalog.toolTip    = ToolTip.imgCatalog.rawValue
        imgRadioImageSet.toolTip   = ToolTip.imageSet.rawValue
        imgRadioImagesOnly.toolTip = ToolTip.imgOnly.rawValue
        imgCheckboxFolder.toolTip  = ToolTip.folder.rawValue
    }
    
    private func getPriorSettings() {
        // Get prior Options and File Type selections
        if let savedValue = defaults.object(forKey: Key.iphone.rawValue)    { checkboxIPhone.state  = savedValue as! NSControl.StateValue }
        if let savedValue = defaults.object(forKey: Key.ipad.rawValue)      { checkboxIPad.state    = savedValue as! NSControl.StateValue }
        if let savedValue = defaults.object(forKey: Key.carplay.rawValue)   { checkboxCarplay.state = savedValue as! NSControl.StateValue }
        if let savedValue = defaults.object(forKey: Key.mac.rawValue)       { checkboxMac.state     = savedValue as! NSControl.StateValue }
        if let savedValue = defaults.object(forKey: Key.watch.rawValue)     { checkboxWatch.state   = savedValue as! NSControl.StateValue }
        if let savedValue = defaults.object(forKey: Key.assets.rawValue)    { radioAssets.state     = savedValue as! NSControl.StateValue }
        if let savedValue = defaults.object(forKey: Key.iconSet.rawValue)   { radioIconSet.state    = savedValue as! NSControl.StateValue }
        if let savedValue = defaults.object(forKey: Key.imageOnly.rawValue) { radioImagesOnly.state = savedValue as! NSControl.StateValue }
        if let savedValue = defaults.object(forKey: Key.folder.rawValue)    { checkboxFolder.state  = savedValue as! NSControl.StateValue }
        
        if let savedValue = defaults.object(forKey: Key.imgUni.rawValue)     { imgCheckboxUni.state     = savedValue as! NSControl.StateValue }
        if let savedValue = defaults.object(forKey: Key.imgIphone.rawValue)  { imgCheckboxIPhone.state  = savedValue as! NSControl.StateValue }
        if let savedValue = defaults.object(forKey: Key.imgIpad.rawValue)    { imgCheckboxIPad.state    = savedValue as! NSControl.StateValue }
        if let savedValue = defaults.object(forKey: Key.imgCarplay.rawValue) { imgCheckboxCarplay.state = savedValue as! NSControl.StateValue }
        if let savedValue = defaults.object(forKey: Key.imgMac.rawValue)     { imgCheckboxMac.state     = savedValue as! NSControl.StateValue }
        if let savedValue = defaults.object(forKey: Key.imgWatch.rawValue)   { imgCheckboxWatch.state   = savedValue as! NSControl.StateValue }
        if let savedValue = defaults.object(forKey: Key.imgAppleTV.rawValue) { imgCheckboxAppleTV.state = savedValue as! NSControl.StateValue }
        if let savedValue = defaults.object(forKey: Key.imgCatalog.rawValue) { imgRadioCatalog.state    = savedValue as! NSControl.StateValue }
        if let savedValue = defaults.object(forKey: Key.imageSet.rawValue)   { imgRadioImageSet.state   = savedValue as! NSControl.StateValue }
        if let savedValue = defaults.object(forKey: Key.imgOnly.rawValue)    { imgRadioImagesOnly.state = savedValue as! NSControl.StateValue }
        if let savedValue = defaults.object(forKey: Key.imgFolder.rawValue)  { imgCheckboxFolder.state  = savedValue as! NSControl.StateValue }
        constraintImageWidth.constant = CGFloat(defaults.float(forKey: Key.slider.rawValue))
    }
}








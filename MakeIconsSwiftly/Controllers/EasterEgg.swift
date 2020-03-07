//
//  EasterEgg.swift
//  Make Icons Swiftly
//
//  Created by Marcy Vernon on 2/6/20.
//  Copyright © 2020 Marcy Vernon. All rights reserved.
//

import AppKit

struct EasterEgg {
    //MARK: - Create 1024x1024 image
    let size = NSMakeSize(1024, 1024)
    
    func createRandomImage() -> NSImage {
        let drawnImage = NSImage.init(size: size)
        
        let rep = NSBitmapImageRep.init(bitmapDataPlanes: nil,
                                        pixelsWide      : Int(size.width),
                                        pixelsHigh      : Int(size.height),
                                        bitsPerSample   : 8,
                                        samplesPerPixel : 4,
                                        hasAlpha        : true,
                                        isPlanar        : false,
                                        colorSpaceName  : NSColorSpaceName.calibratedRGB,
                                        bytesPerRow     : 0,
                                        bitsPerPixel    : 0)
        
        if let rep = rep { drawnImage.addRepresentation(rep) }
        drawnImage.lockFocus()
        if let ctx = NSGraphicsContext.current?.cgContext { drawImage(ctx) }
        drawnImage.unlockFocus()
        return drawnImage
    }
    
//MARK: - Set Color Palette
    private func drawImage(_ ctx: CGContext) {
        let colorPaletteArray: [ColorPalette] = [
            [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0.8868955374, green: 0.6392090321, blue: 0.1258786619, alpha: 1)],[#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)],[#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)],[#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1),#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)],[#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)],[#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0.8868955374, green: 0.6392090321, blue: 0.1258786619, alpha: 1)],[#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)],
            [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0.8868955374, green: 0.6392090321, blue: 0.1258786619, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)],[#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)],[#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)],[#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)],[#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)],[#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)],[#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1),#colorLiteral(red: 0.9372549057, green: 0.2146090913, blue: 0.3167121166, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)],
            [#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1),#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1),#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)],[#colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1),#colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1),#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)],[#colorLiteral(red: 0.4977706671, green: 0.3513424397, blue: 0.6910072565, alpha: 1),#colorLiteral(red: 0.3698204756, green: 0.7371614575, blue: 0.8751025796, alpha: 1),#colorLiteral(red: 0.8993441463, green: 0.2883025408, blue: 0.5330150723, alpha: 1)],[#colorLiteral(red: 0.3900953829, green: 0.7725836635, blue: 0.9186674953, alpha: 1),#colorLiteral(red: 0.91161865, green: 0.293033123, blue: 0.5408118367, alpha: 1),#colorLiteral(red: 0.9197928309, green: 0.655354023, blue: 0.1380523145, alpha: 1)],[#colorLiteral(red: 0.753066957, green: 0.4135034084, blue: 0.5106909871, alpha: 1),#colorLiteral(red: 0.9857560992, green: 0.5815768242, blue: 0.5616346002, alpha: 1),#colorLiteral(red: 0.9463739991, green: 0.7892032266, blue: 0.7809584141, alpha: 1)],[#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1),#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)],[#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        ]
        
        let design = Int.random(in: 1...10)
        
        switch design {
            case 1  : paletteShapes(ctx, colors: colorPaletteArray.randomElement() ?? [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0.8868955374, green: 0.6392090321, blue: 0.1258786619, alpha: 1)], isSquare: true)
            case 2  : paletteShapes(ctx, colors: [CGColor.randomDark, CGColor.randomMedium, CGColor.randomLight], isSquare: true)
            case 3  : paletteShapes(ctx, colors: colorPaletteArray.randomElement() ?? [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0.8868955374, green: 0.6392090321, blue: 0.1258786619, alpha: 1)], isSquare: true)
            case 4  : paletteShapes(ctx, colors: [CGColor.randomLight, CGColor.randomMedium, CGColor.randomDark], isSquare: true)
            case 5  : paletteShapes(ctx, colors: colorPaletteArray.randomElement() ?? [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0.8868955374, green: 0.6392090321, blue: 0.1258786619, alpha: 1)], isSquare: true)
            case 6  : paletteShapes(ctx, colors: colorPaletteArray.randomElement() ?? [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0.8868955374, green: 0.6392090321, blue: 0.1258786619, alpha: 1)], isSquare: false)
            case 7  : paletteShapes(ctx, colors: [CGColor.randomDark, CGColor.randomMedium, CGColor.randomLight], isSquare: false)
            case 8  : paletteShapes(ctx, colors: colorPaletteArray.randomElement() ?? [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0.8868955374, green: 0.6392090321, blue: 0.1258786619, alpha: 1)], isSquare: false)
            case 9  : paletteShapes(ctx, colors: [CGColor.randomLight, CGColor.randomMedium, CGColor.randomDark], isSquare: false)
            case 10 : paletteShapes(ctx, colors: colorPaletteArray.randomElement() ?? [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0.8868955374, green: 0.6392090321, blue: 0.1258786619, alpha: 1)], isSquare: false)
            default : break
        }
    }
    
    //MARK: - Draw Colored Squares
    private func paletteShapes(_ context: CGContext, colors: ColorPalette, isSquare: Bool) {

        let rect = NSMakeRect(0, 0, size.width, size.height)

        context.setFillColor(colors[0])
        context.fill(rect)
        
        let ranges: [ClosedRange<CGFloat>] = [(1.08...2.0), (1.1...3.0), (1.2...4.0), (4.0...5.0) ]
        
        for i in (1...4) {
            let color = i < 3 ? colors[i] : colors.randomElement() ?? .clear
            context.setFillColor(color)
            let rect  = genRandomRect(midX: rect.midX, midY: rect.midY, range: ranges[i-1])
            isSquare == true ? context.fill(rect) : context.fillEllipse(in: rect)
        }
    }

    //MARK: - Randomize Square Size
    private func genRandomRect(midX: CGFloat, midY: CGFloat, range: ClosedRange<CGFloat>) -> NSRect {
        let random = CGFloat.random(in: range)
        let width  = size.width / random
        let height = size.height / random
        let origin = CGPoint(x: midX - (width * 0.5), y: midY - (height * 0.5))
        let size   = NSSize(width: width, height: height)
        return NSRect(origin: origin, size: size)
    }
} //end of EasterEgg

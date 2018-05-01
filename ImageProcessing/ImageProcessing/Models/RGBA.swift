//
//  RGBA.swift
//  ImageProcessing
//
//  Created by Artem Orlov on 01/05/2018.
//  Copyright © 2018 ArtemOrlov. All rights reserved.
//

import UIKit

class RGBA {

    private let bitsPerComponent = 8
    private let bytesPerPixel = 4

    var pixels: UnsafeMutableBufferPointer<Pixel>
    private(set) var width: Int
    private(set) var height: Int

    init?(image: UIImage) {
        guard let cgImage = image.cgImage else {
            return nil
        }
        width = Int(image.size.width)
        height = Int(image.size.height)
        let bytesPerRow = width * bytesPerPixel
        let imageData = UnsafeMutablePointer<Pixel>.allocate(capacity: width * height)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        var bitmapInfo: UInt32 = CGBitmapInfo.byteOrder32Big.rawValue
        bitmapInfo |= CGImageAlphaInfo.premultipliedLast.rawValue & CGBitmapInfo.alphaInfoMask.rawValue

        guard let imageContext = CGContext(data: imageData, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo) else {
            return nil
        }
        imageContext.draw(cgImage, in: CGRect(origin: CGPoint(x: 0,y :0), size: image.size))
        pixels = UnsafeMutableBufferPointer<Pixel>(start: imageData, count: width * height)
    }

    func toUIImage() -> UIImage? {
        let bytesPerRow = width * bytesPerPixel
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        var bitmapInfo: UInt32 = CGBitmapInfo.byteOrder32Big.rawValue
        bitmapInfo |= CGImageAlphaInfo.premultipliedLast.rawValue & CGBitmapInfo.alphaInfoMask.rawValue
        guard let imageContext = CGContext(data: pixels.baseAddress, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo, releaseCallback: nil, releaseInfo: nil) else {
            return nil
        }
        guard let cgImage = imageContext.makeImage() else {
            return nil
        }
        return UIImage(cgImage: cgImage)
    }
}

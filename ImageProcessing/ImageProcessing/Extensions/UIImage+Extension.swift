//
//  UIImage+Extension.swift
//  ImageProcessing
//
//  Created by Artem Orlov on 27/04/2018.
//  Copyright © 2018 ArtemOrlov. All rights reserved.
//

import UIKit

extension UIImage {
    
    var grayscale: UIImage? {
        let context = CIContext()
        let currentFilter = CIFilter(name: "CIPhotoEffectMono")
        currentFilter?.setValue(CIImage(image: self), forKey: kCIInputImageKey)

        guard let output = currentFilter?.outputImage,
            let cgImage = context.createCGImage(output, from: output.extent) else {
                return nil
        }
        let processedImage = UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)

        return processedImage
    }

    var invert: UIImage? {
        let context = CIContext()
        let currentFilter = CIFilter(name: "CIColorInvert")
        currentFilter?.setValue(CIImage(image: self), forKey: kCIInputImageKey)

        guard let output = currentFilter?.outputImage,
            let cgImage = context.createCGImage(output, from: output.extent) else {
                return nil
        }
        let processedImage = UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)

        return processedImage
    }

    var mirror: UIImage? {
        if #available(iOS 10.0, *) {
            return self.withHorizontallyFlippedOrientation()
        } else {
            guard let cgImage = self.cgImage else {
                return nil
            }
            return UIImage(cgImage: cgImage,
                           scale: 1.0,
                           orientation: .upMirrored)
        }
    }

    var mirrorLeftPart: UIImage? {
        guard let rgba = RGBA(image: self) else {
            return nil
        }
        for y in 0..<rgba.height {
            for x in (rgba.width/2)..<rgba.width {
                let index = y * rgba.width + x
                let indexOfMirroredPixel = y * rgba.width + rgba.width - x
                rgba.pixels[index] = rgba.pixels[indexOfMirroredPixel]
            }
        }
        return rgba.toUIImage()
    }

    var rotatedImage: UIImage? {

        let rotatedSize = CGSize(width: size.height, height: size.width)

        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap = UIGraphicsGetCurrentContext()

        bitmap?.translateBy(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0)

        bitmap?.rotate(by: .pi / 2)

        draw(in: CGRect(x: -size.width / 2,
                        y: -size.height / 2,
                        width: size.width,
                        height: size.height))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}


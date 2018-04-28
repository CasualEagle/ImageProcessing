//
//  UIImage+Extension.swift
//  ImageProcessing
//
//  Created by Zstudent on 27/04/2018.
//  Copyright © 2018 ArtemOrlov. All rights reserved.
//

import UIKit

extension UIImage {
    
    var mono: UIImage? {
        let context = CIContext(options: nil)
        let currentFilter = CIFilter(name: "CIPhotoEffectMono")
        currentFilter?.setValue(CIImage(image: self), forKey: kCIInputImageKey)

        guard let output = currentFilter?.outputImage,
            let cgImage = context.createCGImage(output, from: output.extent) else {
                return nil
        }
        let processedImage = UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)

        return processedImage
    }

    var flip: UIImage? {
        if #available(iOS 10.0, *) {
            return self.withHorizontallyFlippedOrientation()
        } else {
            guard let cgImage = self.cgImage else {
                return nil
            }
            return UIImage(cgImage: cgImage,
                           scale: 1.0,
                           orientation: .rightMirrored)
        }
    }

    public func imageRotatedByDegrees(degrees: CGFloat, flip: Bool) -> UIImage? {
        let radiansToDegrees: (CGFloat) -> CGFloat = {
            return $0 * (180.0 / CGFloat(M_PI))
        }
        let degreesToRadians: (CGFloat) -> CGFloat = {
            return $0 / 180.0 * CGFloat(M_PI)
        }

        // calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox = UIView(frame: CGRect(origin: .zero, size: size))
        let t = CGAffineTransform(rotationAngle: degreesToRadians(degrees));
        rotatedViewBox.transform = t
        let rotatedSize = rotatedViewBox.frame.size

        // Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap = UIGraphicsGetCurrentContext()

        // Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap?.translateBy(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0)

        //   // Rotate the image context
        bitmap?.rotate(by: degreesToRadians(degrees))

        // Now, draw the rotated/scaled image into the context
        var yFlip: CGFloat

        if(flip){
            yFlip = CGFloat(-1.0)
        } else {
            yFlip = CGFloat(1.0)
        }

        bitmap?.scaleBy(x: yFlip, y: 1.0)
        draw(in: CGRect(x: -size.width / 2,
                        y: -size.height / 2,
                        width: size.width,
                        height: size.height))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}

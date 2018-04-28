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
                           orientation: .upMirrored)
        }
    }
    
}

//
//  ExifService.swift
//  ImageProcessing
//
//  Created by Artem Orlov on 01/05/2018.
//  Copyright © 2018 ArtemOrlov. All rights reserved.
//

import ImageIO
import UIKit

typealias ExifDictionary = [CFString: Any]
class ExifService {

    func getExifData(from image: UIImage?) -> ExifDictionary? {
        guard let image = image else {
            return nil
        }

        guard let imageData = UIImageJPEGRepresentation(image, 1) as CFData? else {
            return nil
        }

        guard let cgImageSource = CGImageSourceCreateWithData(imageData, nil) else {
            return nil
        }

        guard let imageProperties = CGImageSourceCopyPropertiesAtIndex(cgImageSource, 0, nil) as NSDictionary? else {
            return nil
        }
        guard let exifDictionary = imageProperties[kCGImagePropertyExifDictionary] as? ExifDictionary else {
            return nil
        }
        return exifDictionary
    }
}

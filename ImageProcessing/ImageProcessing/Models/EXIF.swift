//
//  EXIF.swift
//  ImageProcessing
//
//  Created by Artem Orlov on 01/05/2018.
//  Copyright © 2018 ArtemOrlov. All rights reserved.
//

import ImageIO
import UIKit

typealias EXIFDictionary = [CFString: Any]
class EXIFService {

    func changeCameraToApp(for image: UIImage?) {
        guard let image = image else {
            return
        }
//        guard let jpeg = UIImageJPEGRepresentation(image, 1.0) else {
//            return
//        }

        guard var exifDictionary = getExifData(from: image) else {
            return
        }
        exifDictionary[kCGImagePropertyExifCameraOwnerName] = "ImageProcessing App"
        
    }

    func getExifData(from image: UIImage?) -> EXIFDictionary? {
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
        guard let exifDictionary = imageProperties[kCGImagePropertyExifDictionary] as? EXIFDictionary else {
            return nil
        }
        print(exifDictionary)
        return exifDictionary
    }
}

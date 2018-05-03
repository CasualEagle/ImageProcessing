//
//  ProcessedImage.swift
//  ImageProcessing
//
//  Created by Zstudent on 28/04/2018.
//  Copyright © 2018 ArtemOrlov. All rights reserved.
//

import UIKit
import CoreData

class ProcessedImage: NSManagedObject {

    @NSManaged fileprivate(set) var date: Date
    @NSManaged fileprivate(set) var image: Data
    @NSManaged fileprivate(set) var thumbnail: Data
    @NSManaged fileprivate(set) var modification: String

    static func insert(into context: NSManagedObjectContext, image: UIImage, modification: String) {
        guard let processedImage = NSEntityDescription.insertNewObject(forEntityName: "ProcessedImage", into: context) as? ProcessedImage else {
            return
        }

        guard let imageData = UIImagePNGRepresentation(image),
        let thumbnail = UIImageJPEGRepresentation(image, 0.2) else {
            return
        }
        processedImage.image = imageData
        processedImage.thumbnail = thumbnail
        processedImage.date = Date()
        processedImage.modification = modification
        context.insert(processedImage)
    }
}

extension ProcessedImage: Managed {
    static var entityName: String {
        return "ProcessedImage"
    }

    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(date), ascending: false)]
    }
}

extension ProcessedImage {
    var imageFromData: UIImage? {
        return UIImage(data: thumbnail)
    }
}

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
    @NSManaged fileprivate(set) var image: UIImage
    @NSManaged fileprivate(set) var modification: String

    static func insert(into context: NSManagedObjectContext, image: UIImage, modification: String) {
        guard let processedImage = NSEntityDescription.insertNewObject(forEntityName: "ProcessedImage", into: context) as? ProcessedImage else {
            return
        }
        processedImage.date = Date()
        processedImage.image = image
        processedImage.modification = modification
        context.insert(processedImage)
    }
}

extension ProcessedImage: Managed {
    static var entityName: String {
        return "ProcessedImage"
    }

    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(date), ascending: true)]
    }
}

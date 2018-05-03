//
//  ProcessedImage.swift
//  ImageProcessing
//
//  Created by Zstudent on 28/04/2018.
//  Copyright © 2018 ArtemOrlov. All rights reserved.
//

import UIKit
import CoreData

final class ProcessedImage: NSManagedObject {

    @NSManaged fileprivate(set) var date: Date
    @NSManaged fileprivate(set) var image: UIImage
    @NSManaged fileprivate(set) var modification: String

    static func insert(into context: NSManagedObjectContext, image: UIImage, modification: String) {
        let processedImage = ProcessedImage()
        processedImage.image = image
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

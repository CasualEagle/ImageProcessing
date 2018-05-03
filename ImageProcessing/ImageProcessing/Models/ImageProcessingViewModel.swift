//
//  ImageProcessingViewModel.swift
//  ImageProcessing
//
//  Created by Zstudent on 28/04/2018.
//  Copyright © 2018 ArtemOrlov. All rights reserved.
//

import UIKit
import CoreData

struct ImageProcessingViewModel {

    private(set) var images: [ProcessedImage] = []

    mutating func modifyImage(modification: Modification, image: UIImage?, context: NSManagedObjectContext, completion: @escaping (Bool) -> ()) {
        guard image != nil else {
            completion(false)
            return
        }
        let newImage: UIImage?

        switch modification {
        case .grayscale:
            newImage = image?.grayscale
        case .mirror:
            newImage = image?.mirror
        case .rotate:
            newImage = image?.imageRotatedByDegrees(degrees: 90)
        case .invert:
            newImage = image?.invert
        case .leftSideMirror:
            newImage = image?.mirrorLeftPart
        }
        guard let modifiedImage = newImage else {
            completion(false)
            return
        }

        ProcessedImage.insert(into: context, image: modifiedImage, modification: modification.rawValue)
//        let processedImage = ProcessedImage(modification: modification.rawValue,
//                                            image: modifiedImage)

        DispatchQueue.main.async {
            completion(true)
        }
    }

    mutating func removeObject(at indexPath: IndexPath) {
        images.remove(at: indexPath.row)
    }

    func fetchData() {
        
    }
}

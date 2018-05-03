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

    func modifyImage(modification: Modification, image: UIImage?, context: NSManagedObjectContext) {
        guard image != nil else {
            return
        }
        DispatchQueue.global().async {
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
                return
            }

            context.performChanges {
                ProcessedImage.insert(into: context, image: modifiedImage, modification: modification.rawValue)
            }
        }
    }

    mutating func removeObject(at indexPath: IndexPath) {
        images.remove(at: indexPath.row)
    }
}

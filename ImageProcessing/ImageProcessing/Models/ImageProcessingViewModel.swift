//
//  ImageProcessingViewModel.swift
//  ImageProcessing
//
//  Created by Artem Orlov on 28/04/2018.
//  Copyright © 2018 ArtemOrlov. All rights reserved.
//

import UIKit

enum TableViewReloadType: Int {
    case nothing, insert, update, delete
}
class ImageProcessingViewModel {

    private(set) var images: [ProcessedImage] = []

    func modifyImage(modification: Modification, image: UIImage?, completion: @escaping (Int?,TableViewReloadType) -> ()) {
        guard image != nil else {
            completion(nil, .nothing)
            return
        }
        let processedImage = ProcessedImage(modification: modification, image: UIImage())
        images.append(processedImage)
        let index = images.index(of: processedImage)
        DispatchQueue.main.async {
            completion(index, .insert)
        }
        sleep(5)
        let newImage: UIImage?
        switch modification {
        case .grayscale:
            newImage = image?.grayscale
        case .mirror:
            newImage = image?.mirror
        case .rotate:
            newImage = image?.rotatedImage
        case .invert:
            newImage = image?.invert
        case .leftSideMirror:
            newImage = image?.mirrorLeftPart
        }
        guard let modifiedImage = newImage else {
            completion(nil, .nothing)
            return
        }
        processedImage.image = modifiedImage
        let finalIndex = images.index(of: processedImage)
        DispatchQueue.main.async {
            completion(finalIndex, .update)
        }
    }

    func removeObject(at indexPath: IndexPath) {
        images.remove(at: indexPath.row)
    }
}

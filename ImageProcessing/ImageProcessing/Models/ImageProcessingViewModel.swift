//
//  ImageProcessingViewModel.swift
//  ImageProcessing
//
//  Created by Artem Orlov on 28/04/2018.
//  Copyright © 2018 ArtemOrlov. All rights reserved.
//

import UIKit

protocol UpdateFilteringCell: class {
    func updateCell(at index: Int, progress: Float)
}

enum TableViewReloadType: Int {
    case nothing, insert, update, delete
}

class ImageProcessingViewModel {

    private(set) var images: [ProcessedImage] = []
    weak var delegate: UpdateFilteringCell!

    func modifyImage(modification: Modification, image: UIImage?, completion: @escaping (Int?,TableViewReloadType) -> ()) {
        guard image != nil else {
            completion(nil, .nothing)
            return
        }
        let processedImage = ProcessedImage(modification: modification, image: UIImage())
        images.append(processedImage)
        guard let index = images.index(of: processedImage) else {
            completion(nil, .nothing)
            return
        }
        DispatchQueue.main.async {
            completion(index, .insert)
        }

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
        let seconds = arc4random_uniform(260) + 50
        for second in 1...seconds {
            DispatchQueue.main.async {
                self.delegate.updateCell(at: index, progress: Float(second) / Float(seconds))
            }
            usleep(100000)
        }
        processedImage.image = modifiedImage
        guard let finalIndex = images.index(of: processedImage) else {
            return
        }
        processedImage.isFiltering = false
        DispatchQueue.main.async {
            completion(finalIndex, .update)
        }
    }

    func removeObject(at indexPath: IndexPath) {
        images.remove(at: indexPath.row)
    }
}

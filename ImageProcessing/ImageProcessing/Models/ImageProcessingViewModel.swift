//
//  ImageProcessingViewModel.swift
//  ImageProcessing
//
//  Created by Zstudent on 28/04/2018.
//  Copyright © 2018 ArtemOrlov. All rights reserved.
//

import UIKit

class ImageProcessingViewModel {

    private(set) var images: [ProcessedImage] = []

    func modifyImage(modification: Modification, image: UIImage?, completion: @escaping (Int?,Int) -> ()) {
        guard image != nil else {
            completion(nil, 0)
            return
        }
        let processedImage = ProcessedImage(modification: modification, image: UIImage())
        images.append(processedImage)
        let index = images.index(of: processedImage)
        DispatchQueue.main.async {
            completion(index, 1)
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
            completion(nil, 0)
            return
        }
        processedImage.image = modifiedImage
        print(processedImage)
        let finalIndex = images.index(of: processedImage)
        DispatchQueue.main.async {
            completion(finalIndex, 2)
        }
    }

    func removeObject(at indexPath: IndexPath) {
        images.remove(at: indexPath.row)
    }
}

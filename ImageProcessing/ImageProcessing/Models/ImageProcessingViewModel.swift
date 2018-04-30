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

    func modifyImage(modification: Modification, image: UIImage?, completion: @escaping (Bool) -> ()) {
        guard image != nil else {
            completion(false)
            return
        }
        DispatchQueue.global().async {
            sleep(5)
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
            }
            guard let modifiedImage = newImage else {
                completion(false)
                return
            }

            self.images.insert(ProcessedImage(modification: modification,
                                              image: modifiedImage),
                               at: 0)
            DispatchQueue.main.async {
                completion(true)
            }
        }

    }

    func removeObject(at indexPath: IndexPath) {
        images.remove(at: indexPath.row)
    }
}

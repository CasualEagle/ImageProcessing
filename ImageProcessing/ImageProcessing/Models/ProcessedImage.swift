//
//  ProcessedImage.swift
//  ImageProcessing
//
//  Created by Zstudent on 28/04/2018.
//  Copyright © 2018 ArtemOrlov. All rights reserved.
//

import UIKit

class ProcessedImage: NSObject {
    let modification: Modification
    var image: UIImage

    init(modification: Modification, image: UIImage) {
        self.modification = modification
        self.image = image
    }
}

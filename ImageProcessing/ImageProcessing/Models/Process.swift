//
//  Process.swift
//  ImageProcessing
//
//  Created by Artem Orlov on 29/04/2018.
//  Copyright © 2018 ArtemOrlov. All rights reserved.
//

import Foundation

class Process {

    let processedImage: ProcessedImage

    var isProcessing = false
    var progress: Float = 0

    init(processedImage: ProcessedImage) {
        self.processedImage = processedImage
    }
}

class ProcessOperation: Operation {
    
}

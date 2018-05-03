//
//  Constants.swift
//  ImageProcessing
//
//  Created by Artem Orlov on 29/04/2018.
//  Copyright © 2018 ArtemOrlov. All rights reserved.
//

import Foundation

enum Constants {

    enum Title: String {
        case imageProcessing = "Image Processing"
        case exif = "EXIF"
    }

    enum Button {
        static let chooseImage = "Choose image from:"
        static let ok = "OK"
        static let cancel = "Cancel"
    }

    enum Message {
        static let saved = "Saved!"
        static let saveError = "Save error"
        static let imageSaved = "The image has been saved to your photos."
    }
}

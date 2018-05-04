//
//  ProcessingButton.swift
//  ImageProcessing
//
//  Created by Artem Orlov on 29/04/2018.
//  Copyright © 2018 ArtemOrlov. All rights reserved.
//

import UIKit

enum Modification: String {
    case rotate = "Rotate"
    case grayscale = "Grayscale"
    case mirror = "Mirror"
    case invert = "Invert Colors"
    case leftSideMirror = "Mirror left side"
}

class ProcessingButton: UIButton {

    var modification: Modification = .rotate

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setBorder()
    }

    private func setBorder() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 5
    }
}

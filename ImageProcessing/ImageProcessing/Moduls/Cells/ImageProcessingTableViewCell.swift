//
//  ImageProcessingTableViewCell.swift
//  ImageProcessing
//
//  Created by Zstudent on 28/04/2018.
//  Copyright © 2018 ArtemOrlov. All rights reserved.
//

import UIKit

class ImageProcessingTableViewCell: UITableViewCell {

    @IBOutlet weak var modificationLabel: UILabel!
    @IBOutlet weak var processedImageView: UIImageView!

    static let reuseID = "ImageProcessingTableViewCell"
    
    func configure(processedImage: ProcessedImage) {
        modificationLabel.text = processedImage.modification
        processedImageView.image = processedImage.image
    }
}

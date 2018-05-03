//
//  ImageProcessingTableViewCell.swift
//  ImageProcessing
//
//  Created by Artem Orlov on 28/04/2018.
//  Copyright © 2018 ArtemOrlov. All rights reserved.
//

import UIKit

class ImageProcessingTableViewCell: UITableViewCell {

    @IBOutlet weak var modificationLabel: UILabel!
    @IBOutlet weak var processedImageView: UIImageView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!

    static let reuseID = "ImageProcessingTableViewCell"
    
    func configure(processedImage: ProcessedImage) {
        modificationLabel.text = processedImage.modification.rawValue
        processedImageView.image = processedImage.image

        progressView.isHidden = !processedImage.isFiltering
        progressLabel.isHidden = !processedImage.isFiltering
    }

    func showProgress(_ progress: Float) {
        progressView.progress = progress
        progressLabel.text = "\(Int(progress * 100))" + "%"
    }
    
}

//
//  ImageProcessingViewController.swift
//  ImageProcessing
//
//  Created by Artem Orlov on 27/04/2018.
//  Copyright © 2018 ArtemOrlov. All rights reserved.
//

import UIKit

class ImageProcessingViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!

    @IBAction private func chooseImage(_ sender: UIButton) {
        presentActionSheet(title: nil,
                           message: "Choose image from:",
                           options: .library, .camera, .cancel)
        { option in

            switch option {
            case .camera:
                print("1")
            case .library:
                print("2")
            case .cancel:
                print("3")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

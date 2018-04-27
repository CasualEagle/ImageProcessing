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
        presentActionSheet(title: "Choose image from:",
                           message: nil,
                           options: .library, .camera, .cancel)
        { [weak self] option in

            switch option {
            case .camera:
                self?.openCamera()
            case .library:
                self?.openImageLibrary()
            case .cancel:
                break
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        print(UIImagePickerController.isSourceTypeAvailable(.photoLibrary))
        print(UIImagePickerController.isSourceTypeAvailable(.camera))
    }

    private func openCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            return
        }
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }

    private func openImageLibrary() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            return
        }
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)

    }
}

extension ImageProcessingViewController: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }

}

extension ImageProcessingViewController: UINavigationControllerDelegate {

}

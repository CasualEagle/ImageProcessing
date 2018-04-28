//
//  ImageProcessingViewController.swift
//  ImageProcessing
//
//  Created by Artem Orlov on 27/04/2018.
//  Copyright © 2018 ArtemOrlov. All rights reserved.
//

import UIKit
import CoreGraphics

class ImageProcessingViewController: UIViewController {

    @IBOutlet weak var finalImageView: UIImageView!
    @IBOutlet private weak var imageView: UIImageView!

    @IBAction private  func grayscaleImage(_ sender: UIButton) {
        finalImageView.image = imageView.image?.mono
    }
    
    @IBAction private func rotateImage(_ sender: UIButton) {
        finalImageView.image = imageView.image?.imageRotatedByDegrees(degrees: 90, flip: false)
    }

    @IBAction private func mirrorImage(_ sender: UIButton) {
            finalImageView.image = imageView.image?.flip
    }

    @IBAction private func chooseImage(_ sender: UIButton) {
        presentActionSheet(
            title: "Choose image from:",
            message: nil,
            options: .photoLibrary, .camera, .cancel) { [weak self] option in

                switch option {
                case .camera:
                    self?.openImagePicker(.camera)
                case .photoLibrary:
                    self?.openImagePicker(.photoLibrary)
                default:
                    break
                }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    private func openImagePicker(_ source: UIImagePickerControllerSourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(source) else {
            return
        }
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
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

extension ImageProcessingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }


}

extension ImageProcessingViewController: UITableViewDelegate {
    
}

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
    @IBOutlet private weak var tableView: UITableView!

    @IBAction private  func grayscaleImage(_ sender: UIButton) {
        guard let image = imageView.image?.mono else {
            return
        }
        let processedImage = ProcessedImage(modification: .grayscale, image: image)
        images.insert(processedImage, at: 0)
        tableView.reloadData()
    }
    
    @IBAction private func rotateImage(_ sender: UIButton) {
        guard let image = imageView.image?.imageRotatedByDegrees(degrees: 90, flip: false) else {
            return
        }
        let processedImage = ProcessedImage(modification: .rotate, image: image)
        images.insert(processedImage, at: 0)
        tableView.reloadData()
    }

    @IBAction private func mirrorImage(_ sender: UIButton) {
        guard let image = imageView.image?.flip else {
            return
        }
        let processedImage = ProcessedImage(modification: .mirror, image: image)
        images.insert(processedImage, at: 0)
        tableView.reloadData()
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

    var images: [ProcessedImage] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: ImageProcessingTableViewCell.reuseID,
                        bundle: nil)
        tableView.register(nib,
                           forCellReuseIdentifier: ImageProcessingTableViewCell.reuseID)
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
        return images.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageProcessingTableViewCell.reuseID, for: indexPath) as! ImageProcessingTableViewCell
        cell.configure(processedImage: images[indexPath.row])
        return cell
    }


}

extension ImageProcessingViewController: UITableViewDelegate {
    
}

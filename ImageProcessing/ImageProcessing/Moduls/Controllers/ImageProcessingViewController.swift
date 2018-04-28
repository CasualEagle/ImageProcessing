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

    @IBOutlet private weak var chooseImageLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var tableView: UITableView!

    @IBAction private  func grayscaleImage(_ sender: UIButton) {
        viewModel.modifyImage(modification: .grayscale, image: imageView.image) { [weak self] success in
            if success {
                self?.tableView.reloadData()
            }
        }
    }
    
    @IBAction private func rotateImage(_ sender: UIButton) {
        viewModel.modifyImage(modification: .rotate, image: imageView.image) { [weak self] success in
            if success {
                self?.tableView.reloadData()
            }
        }
    }

    @IBAction private func mirrorImage(_ sender: UIButton) {
        viewModel.modifyImage(modification: .mirror, image: imageView.image) { [weak self] success in
            if success {
                self?.tableView.reloadData()
            }
        }
    }

    var images: [ProcessedImage] = []
    var viewModel = ImageProcessingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: ImageProcessingTableViewCell.reuseID,
                        bundle: nil)
        tableView.register(nib,
                           forCellReuseIdentifier: ImageProcessingTableViewCell.reuseID)

        imageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gesture)
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

    @objc private func chooseImage() {
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
    private func savePhotoToLibrary(at indexPath: IndexPath) {
        let image = viewModel.images[indexPath.row].image
        UIImageWriteToSavedPhotosAlbum(image,
                                       self,
                                       #selector(image(_:didFinishSavingWithError:contextInfo:)),
                                       nil)
    }

    @objc private func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {

            let alert = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Saved!", message: "The image has been saved to your photos.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
}

extension ImageProcessingViewController: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        imageView.image = image
        dismiss(animated: true, completion: nil)
        chooseImageLabel.isHidden = true
    }

}

extension ImageProcessingViewController: UINavigationControllerDelegate {

}

extension ImageProcessingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.images.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageProcessingTableViewCell.reuseID, for: indexPath) as! ImageProcessingTableViewCell
        cell.configure(processedImage: viewModel.images[indexPath.row])
        return cell
    }


}

extension ImageProcessingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presentActionSheet(title: nil, message: nil, options: .save, .useAsPrimary, .delete, .cancel) { [weak self] option in
            switch option {
            case .save:
                self?.savePhotoToLibrary(at: indexPath)
            case .delete:
                self?.viewModel.removeObject(at: indexPath)
                tableView.reloadData()
            case .useAsPrimary:
                self?.imageView.image = self?.viewModel.images[indexPath.row].image
            default:
                break
            }
        }
    }
}

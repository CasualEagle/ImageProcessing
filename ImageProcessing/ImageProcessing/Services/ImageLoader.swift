//
//  ImageLoader.swift
//  ImageProcessing
//
//  Created by Artem Orlov on 29/04/2018.
//  Copyright © 2018 ArtemOrlov. All rights reserved.
//

import UIKit

protocol ImageLoaderDelegate: class {
    func updateImage(_ image: UIImage)
    func showProgress(_ progress: Float)
}

class ImageLoader: NSObject {

    private(set) var downloadTask: URLSessionDownloadTask?
    weak var imageLoaderDelegate: ImageLoaderDelegate?

    func downloadImage(from url: URL) {
        downloadTask?.cancel()
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        downloadTask = session.downloadTask(with: url)
        downloadTask?.resume()
    }
}

    // MARK: URLSessionDownloadDelegate

extension ImageLoader: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let imageData = try? Data(contentsOf: location),
            let image = UIImage(data: imageData) else {
                return
        }
        DispatchQueue.main.async { [weak self] in
            self?.imageLoaderDelegate?.updateImage(image)
        }
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        DispatchQueue.main.async { [weak self] in
            self?.imageLoaderDelegate?.showProgress(progress)
        }
    }
}

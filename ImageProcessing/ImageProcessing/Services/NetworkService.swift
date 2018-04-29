//
//  NetworkService.swift
//  ImageProcessing
//
//  Created by Artem Orlov on 29/04/2018.
//  Copyright © 2018 ArtemOrlov. All rights reserved.
//

import UIKit

class NetworkService: NSObject {

    var percentage: Float = 0

    private var downloadTask: URLSessionDataTask?
    func downloadImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        // Create destination URL
        guard let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        let string = "https://upload.wikimedia.org/wikipedia/commons/4/45/2009_Landscape_plan_-_St._Elizabeths_Hospital_West_Campus%2C_2700_Martin_Luther_King_Jr._Avenue%2C_Southeast%2C_Washington%2C_District_of_Columbia%2C_DC_HALS_DC-11_%28sheet_5_of_7%29.tif"
        let fileURL = URL(string: string)
        let destinationFileUrl = documentsUrl.appendingPathComponent(string)
        //Create URL to the source file you want to download

        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: OperationQueue())
        let request = URLRequest(url:fileURL!)

        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                }

                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                }

            } else {
                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription);
            }
        }
        task.resume()
    }
}

extension NetworkService: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("finished")
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        percentage = Float(totalBytesWritten / totalBytesExpectedToWrite)
        print(percentage)
    }
}

//
//  ExifDataViewController.swift
//  ImageProcessing
//
//  Created by Artem Orlov on 01/05/2018.
//  Copyright © 2018 ArtemOrlov. All rights reserved.
//

import UIKit

class ExifDataViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    var exifDictionary: ExifDictionary = [:]

    private let cellID = "cellID"
    override func viewDidLoad() {
        super.viewDidLoad()

        title = Constants.Title.exif.rawValue
        tableView.register(SubtitleTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView(frame: .zero)
    }
}

extension ExifDataViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exifDictionary.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let key = Array(exifDictionary.keys)[indexPath.row]
        cell.textLabel?.text = key as String
        cell.detailTextLabel?.text = String(describing: exifDictionary[key] ?? "No data")
        return cell
    }
}

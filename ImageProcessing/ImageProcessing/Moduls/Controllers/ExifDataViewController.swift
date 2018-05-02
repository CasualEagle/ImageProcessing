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
    var exifDictionary: EXIFDictionary = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "EXIF"
        tableView.register(SubtitleTableViewCell.self, forCellReuseIdentifier: "cell")

    }

    private func getKeys(for dictionary: EXIFDictionary) -> [CFString] {
        let keys = Array(dictionary.keys)
        print(Array(dictionary.keys))
        let value = dictionary[keys[0]]
        print("\(String(describing: value))")
        return keys
    }
}

extension ExifDataViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exifDictionary.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let keys = getKeys(for: exifDictionary)
        cell.textLabel?.text = keys[indexPath.row] as String
        cell.detailTextLabel?.text = String(describing: exifDictionary[keys[indexPath.row]] ?? "No data") 
        return cell
    }
}

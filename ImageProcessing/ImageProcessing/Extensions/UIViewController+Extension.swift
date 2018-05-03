//
//  UIView+Extension.swift
//  ImageProcessing
//
//  Created by Artem Orlov on 27/04/2018.
//  Copyright © 2018 ArtemOrlov. All rights reserved.
//

import UIKit

extension UIViewController {

    func presentActionSheet(title: String?, message: String?, options: AlertOption..., completion: @escaping (AlertOption) -> Void) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .actionSheet)

        for option in options {
            let style: UIAlertActionStyle
            switch option {
            case .cancel:
                style = .cancel
            case .delete:
                style = .destructive
            default:
                style = .default
            }

            let action = UIAlertAction(title: option.rawValue,
                                       style: style) { _ in
                completion(option)
            }
            alertController.addAction(action)
        }
        self.present(alertController, animated: true, completion: nil)
    }
}

//
//  UIView+Alert.swift
//  CountOnMe
//
//  Created by Enzo Gammino on 02/06/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func showAlert(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//        present(alertVC, animated: true, completion: nil)
    }
}

//
//  ErrorHandling.swift
//  Yum-Recipe
//
//  Created by Shrouk Yasser on 31/07/2023.
//

import UIKit

extension UITextField {
    func showErrorBorder() {
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 1.0
    }
    
    func removeErrorBorder() {
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 0.0
    }
}

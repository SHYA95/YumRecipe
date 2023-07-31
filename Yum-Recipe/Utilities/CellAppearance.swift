//
//  CellAppearance.swift
//  Yum-Recipe
//
//  Created by Shrouk Yasser on 31/07/2023.
//

import Foundation
import UIKit
// MARK: - Cell Appearance

extension RecipeCollectionViewCell {
    func setupCellAppearance() {
        layer.cornerRadius = 15
        layer.backgroundColor = UIColor.white.cgColor
        // Apply shadow
        layer.shadowColor = UIColor.red.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.5
        
    }
    
}

//
//  RecipeCollectionViewCell.swift
//  Yum-Recipe
//
//  Created by Shrouk Yasser on 30/07/2023.
//
import UIKit
import Kingfisher

protocol RecipeCollectionViewCellDelegate: AnyObject {
    
}

class RecipeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var RecipeImage: UIImageView!
    @IBOutlet weak var RecipeName: UILabel!
    @IBOutlet weak var RecipeTime: UILabel!
    @IBOutlet weak var RecipeFats: UILabel!
    @IBOutlet weak var RecipeRating: UILabel!
    weak var delegate: RecipeCollectionViewCellDelegate?
    private var recipeID: String?
    private var isFavorite: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellAppearance()
    }
    
    override var isSelected: Bool {
        didSet {
           
        }
    }
    
    // Function to generate a random rating between 1 and 5 (inclusive)
    func generateRandomRating() -> String {
        let randomRating = Double.random(in: 1...5)
        return String(format: "%.1f", randomRating)
    }
    
    func setupCell(_ model: RecipesModel) {
        RecipeImage.kf.setImage(with: URL(string: model.image ?? ""))
        RecipeName.text = model.name
        RecipeTime.text = model.time
        RecipeFats.text = model.fats
        RecipeRating.text = generateRandomRating()
        
        
    }
    
    
}

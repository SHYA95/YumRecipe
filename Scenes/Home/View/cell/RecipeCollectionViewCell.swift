//
//  RecipeCollectionViewCell.swift
//  Yum-Recipe
//
//  Created by Shrouk Yasser on 30/07/2023.
//
import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var RecipeImage: UIImageView!
    @IBOutlet weak var RecipeName: UILabel!
    @IBOutlet weak var RecipeTime: UILabel!
    @IBOutlet weak var RecipeFats: UILabel!
    @IBOutlet weak var RecipeRating: UILabel!
    @IBOutlet weak var FavButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 15
        // Apply shadow
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.5
    }
    
    func configure(with recipe: RecipesModel) {
        // Configure your cell here with the data for each item
        RecipeName.text = recipe.name
        RecipeTime.text = recipe.time
        RecipeFats.text = recipe.fats
        RecipeRating.text = "\(String(describing: recipe.rating))"
        // For simplicity, set a placeholder image for now
        RecipeImage.image = UIImage(named: recipe.image ?? "chef")
    }
    
    @IBAction func FavButton(_ sender: UIButton) {
    }
}

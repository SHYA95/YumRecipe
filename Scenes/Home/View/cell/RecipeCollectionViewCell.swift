//
//  RecipeCollectionViewCell.swift
//  Yum-Recipe
//
//  Created by Shrouk Yasser on 30/07/2023.
//
import UIKit
import Kingfisher

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
        RecipeImage.kf.setImage(with: URL(string: model.image!))
        RecipeName.text = model.name
        RecipeTime.text = model.time
        RecipeFats.text = model.fats
        RecipeRating.text = generateRandomRating()
        //RecipeRating.text = "\(String(RandomNumberGenerator[1:5]/5))"
    }
    
    
    

    @IBAction func FavButton(_ sender: UIButton) {
        
    }
}

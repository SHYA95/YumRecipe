//
//  RecipeDetails.swift
//  Yum-Recipe
//
//  Created by Shrouk Yasser on 30/07/2023.
//

import UIKit
import Kingfisher

protocol RecipeDetailsViewControllerDelegate: AnyObject {
    func didToggleFavoriteStatus(for recipeID: String)
}


class RecipeDetailsViewController: UIViewController {
    weak var delegate: RecipeDetailsViewControllerDelegate?
    var viewModel: DetailsRecipeViewModel?
    var recipeIDString: String?
    
    @IBOutlet weak var RecipeImage: UIImageView!
    @IBOutlet weak var FavButton: UIButton!
    @IBOutlet weak var RecipeName: UILabel!
    @IBOutlet weak var RecipeHeadline: UILabel!
    @IBOutlet weak var RecipeTime: UILabel!
    @IBOutlet weak var RecipeFats: UILabel!
    @IBOutlet weak var RecipeCalories: UILabel!
    @IBOutlet weak var RecipeDescription: UILabel!
    @IBOutlet weak var RecipeIngredients: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().barTintColor = UIColor.gray
        
        // Check if viewModel is set before calling setupUI()
        if let viewModel = viewModel {
            setupUI(with: viewModel)
        }
    }
    
    func setupUI(with viewModel: DetailsRecipeViewModel) {
        // Set the values of UI elements based on the ViewModel data
        RecipeName.text = viewModel.recipeData.name
        RecipeHeadline.text = viewModel.recipeData.headline
        RecipeDescription.text = viewModel.recipeData.description
        RecipeIngredients.text = viewModel.recipeData.ingredients
        RecipeFats.text = viewModel.recipeData.fats
        RecipeCalories.text = viewModel.recipeData.calories
        RecipeTime.text = viewModel.recipeData.time
        
        // Load the image using Kingfisher
        if let imageURL = viewModel.recipeData.recipeImage {
            RecipeImage.kf.setImage(with: imageURL)
        } else {
            // If imageURL is nil, you can set a placeholder image here
            RecipeImage.image = UIImage(named: "chef")
        }
        
        // Check if the recipe is in favorites and update the favorite
        recipeIDString = String(viewModel.recipeData.name)
        let isFavorite = FavoriteRecipesManager.shared.isFavoriteRecipe(recipeID: recipeIDString ?? "0")
        updateFavoriteButton(isFavorite: isFavorite)
        
    }

    private func updateFavoriteButton(isFavorite: Bool) {
        let heartImage = isFavorite ? "heart.fill" : "heart"
        FavButton.setImage(UIImage(systemName: heartImage), for: .normal)
    }

    @IBAction func FavButtonTapped(_ sender: UIButton) {
        if let recipeID = viewModel?.recipeData.name {
            let recipeIDString = String(recipeID)
            let isFavorite = FavoriteRecipesManager.shared.isFavoriteRecipe(recipeID: recipeIDString)
            
            if isFavorite {
                FavoriteRecipesManager.shared.removeFavoriteRecipe(recipeID: recipeIDString)
            } else {
                FavoriteRecipesManager.shared.addFavoriteRecipe(recipeID: recipeIDString)
            }
            
            updateFavoriteButton(isFavorite: !isFavorite)
            
            // Notify the delegate (HomeViewController) about the toggle
            delegate?.didToggleFavoriteStatus(for: recipeIDString)
        }
    }
}

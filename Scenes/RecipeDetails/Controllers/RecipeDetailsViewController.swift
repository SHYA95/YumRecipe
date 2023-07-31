//
//  RecipeDetails.swift
//  Yum-Recipe
//
//  Created by Shrouk Yasser on 30/07/2023.
//

import UIKit
import Kingfisher

class RecipeDetailsViewController: UIViewController {

    var viewModel: DetailsRecipeViewModel?

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
            } else {
                // Handle the case where viewModel is nil (optional)
                // For example, show an error message or perform a fallback action
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
            // Set other UI elements accordingly
//            print (viewModel.recipeData.ingredients)
//            print(viewModel.recipeData.name)
            // Load the image using Kingfisher
            if let imageURL = viewModel.recipeData.recipeImage {
                RecipeImage.kf.setImage(with: imageURL)
            } else {
                // If imageURL is nil, you can set a placeholder image here
                RecipeImage.image = UIImage(named: "placeholder_image")
            }
        }

        @IBAction func FavButton(_ sender: UIButton) {
            // Handle favorite button action if needed
        }
    }
   

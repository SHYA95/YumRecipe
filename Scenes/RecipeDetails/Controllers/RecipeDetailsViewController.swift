//
//  RecipeDetails.swift
//  Yum-Recipe
//
//  Created by Shrouk Yasser on 30/07/2023.
//


import UIKit

class RecipeDetailsViewController: UIViewController {
    
    @IBOutlet weak var RecipeImage: UIImageView!
    
    @IBOutlet weak var FavButton: UIButton!
    
    @IBOutlet weak var RecipeName: UILabel!
    
    @IBOutlet weak var RecipeHeadline: UILabel!
    
    @IBOutlet weak var RecipeTime: UILabel!
    
    @IBOutlet weak var RecipeFats: UILabel!
    
    @IBOutlet weak var RecipeCalories: UILabel!
    
    @IBOutlet weak var RecipeDescription: UILabel!
    
    @IBOutlet weak var RecipeIngredients: UILabel!
//    var selectedRecipe: RecipesModel?
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        
        
    }

    @IBAction func FavButton(_ sender: UIButton) {
    }
    
}

//
//  RecipeDetailsViewModel.swift
//  Yum-Recipe
//
//  Created by Shrouk Yasser on 31/07/2023.
//
// RecipeDetailsViewModel.swift

import Foundation

// Protocol defining the properties required for the recipe details
protocol RecipeDetailsProtocol {
    var id: Int { get }
    var name: String { get }
    var headline: String? { get }
    var description: String? { get }
    var backdropPath: String? { get }
    var recipeImage: URL? { get }
    var ingredients: String? { get }
    var time: String { get }
    var calories: String { get }
    var fats: String { get }
    
}

// RecipeDetailsModel implementing the RecipeDetailsProtocol
struct RecipeDetailsModel: RecipeDetailsProtocol {
    var id: Int
    var name: String
    var headline: String?
    var description: String?
    var backdropPath: String?
    var recipeImage: URL?
    var ingredients: String?
    var time: String
    var calories: String
    var fats: String
    
}

// Update the 'RecipesModel' to conform to the 'RecipeDetailsProtocol'

class DetailsRecipeViewModel {
    var recipeData: RecipeDetailsModel
    

    init(recipe: RecipeDetailsModel) { 
        self.recipeData = recipe
    }

    
    // Additional initializer to accept RecipesModel
    convenience init(recipe: RecipesModel) {
        let recipeDetails = recipe.toRecipeDetailsModel()
        self.init(recipe: recipeDetails)
    }
    func toggleFavorite() {
            // Implement the logic to toggle the favorite status here
            // You can use UserDefaults or any other database to store the favorite recipes
            // For demonstration purposes, I will use UserDefaults

            let isFavorite = UserDefaults.standard.bool(forKey: "recipe_\(recipeData.id)_favorite")

            if isFavorite {
                UserDefaults.standard.removeObject(forKey: "recipe_\(recipeData.id)_favorite")
            } else {
                UserDefaults.standard.set(true, forKey: "recipe_\(recipeData.id)_favorite")
            }
        }
    
}


extension RecipesModel {
    func toRecipeDetailsModel() -> RecipeDetailsModel {
        if let recipeId = Int(self.id ?? ""), let imageURL = URL(string: self.image ?? "") {
            return RecipeDetailsModel(
                id: recipeId,
                name: self.name ?? "",
                headline: self.headline,
                description: self.description,
                backdropPath: nil,
                recipeImage: imageURL,
                ingredients: self.ingredients.joined(separator: ", "),
                time: self.time ?? "",
                calories: self.calories ?? "",
                fats: self.fats ?? ""
            )
        } else {
            // Return a default RecipeDetailsModel if the conversion fails
          let imageURL = URL(string: self.image ?? "")
                return RecipeDetailsModel(
                    
                    id: 0,
                    name: self.name ?? "",
                    headline: self.headline,
                    description: self.description,
                    backdropPath: nil,
                    recipeImage: imageURL,
                    ingredients: self.ingredients.joined(separator: ", "),
                    time: self.time ?? "",
                    calories: self.calories ?? "",
                    fats: self.fats ?? ""
                )
            }
        }
    }


//
//  FavoriteRecipesManager.swift
//  Yum-Recipe
//
//  Created by Shrouk Yasser on 01/08/2023.
//

import Foundation

class FavoriteRecipesManager {
    static let shared = FavoriteRecipesManager()
    private var favoriteRecipeIDs: Set<String> = []
    
    func addFavoriteRecipe(recipeID: String) {
        favoriteRecipeIDs.insert(recipeID)
    }
    
    func removeFavoriteRecipe(recipeID: String) {
        favoriteRecipeIDs.remove(recipeID)
    }
    
    func isFavoriteRecipe(recipeID: String) -> Bool {
        return favoriteRecipeIDs.contains(recipeID)
    }
}

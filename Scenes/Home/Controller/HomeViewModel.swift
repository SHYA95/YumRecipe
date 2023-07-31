//
//  HomeViewModel.swift
//  Yum-Recipe
//
//  Created by Shrouk Yasser on 30/07/2023.
//

import Foundation
import Kingfisher

protocol HomeViewModelDelegate: AnyObject {
    func didSelectRecipe(_ recipe: RecipesModel)
}

class HomeViewModel {
    var isLoadingData: Observable<Bool> = Observable(false)
    var dataSource: [RecipesModel]?
    var recipes: Observable<[RecipesModel]> = Observable([])
    
    weak var delegate: HomeViewModelDelegate?
    
    // Function to fetch data from the API
    func getData() {
        if isLoadingData.value ?? true {
            return
        }
        
        isLoadingData.value = true
        APICaller.getRecipesModel { [weak self] result in
            self?.isLoadingData.value = false
            
            switch result {
            case .success(let recipes):
                self?.dataSource = recipes
                self?.mapRecipesData()
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func mapRecipesData() {
        if let dataSource = dataSource {
            recipes.value = dataSource
        }
    }
    
    func getNumberOfRecipes() -> Int {
        return recipes.value?.count ?? 0
    }
    
    func getRecipe(at index: Int) -> RecipesModel? {
        return recipes.value?[index]
    }
    
    func didSelectRecipe(at index: Int) {
        guard let selectedRecipe = getRecipe(at: index) else {
            return
        }
        delegate?.didSelectRecipe(selectedRecipe)
    }
    
    func retrieveRecipe(withId id: String?) -> RecipeDetailsModel? {
        guard let id = id, let recipeId = Int(id) else {
            return nil
        }
        
        // Unwrap 'recipes.value' here
        guard let recipe = recipes.value?.first(where: { $0.id == id }) else {
            return nil
        }
        
        // Unwrap 'recipe.image' here
        guard let imageURL = URL(string: recipe.image ?? "") else {
            return nil
        }
        
        return RecipeDetailsModel(
            id: recipeId,
            name: recipe.name ?? "",
            headline: recipe.headline,
            description: recipe.description,
            backdropPath: nil,
            recipeImage: imageURL,
            ingredients: recipe.ingredients.joined(separator: ", "),
            time: recipe.time ?? "",
            calories: recipe.calories ?? "",
            fats: recipe.fats ?? ""
        )
    }
}

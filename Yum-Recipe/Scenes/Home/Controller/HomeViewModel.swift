//
//  HomeViewModel.swift
//  Yum-Recipe
//
//  Created by Shrouk Yasser on 30/07/2023.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func didSelectRecipe(_ recipe: RecipesModel)
    func didToggleFavoriteStatus(for recipeID: Int)
    func didTapFavoriteButton(for recipeID: Int) // Add this method
}

class HomeViewModel {
    var isLoadingData: Observable<Bool> = Observable(false)
    var dataSource: [RecipesModel]?
    var recipes: Observable<[RecipesModel]> = Observable([])
    private var favoriteRecipeIDs: Set<Int> = []
    
    static let shared = HomeViewModel()
    
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
    
    // New methods for handling favorite recipes
    func toggleFavorite(for recipeIDString: String) {
        if let recipeID = Int(recipeIDString) {
            if favoriteRecipeIDs.contains(recipeID) {
                favoriteRecipeIDs.remove(recipeID)
            } else {
                favoriteRecipeIDs.insert(recipeID)
            }
            delegate?.didToggleFavoriteStatus(for: recipeID)
        }
    }
}

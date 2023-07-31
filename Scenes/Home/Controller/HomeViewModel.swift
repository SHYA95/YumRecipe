//
//  HomeViewModel.swift
//  Yum-Recipe
//
//  Created by Shrouk Yasser on 30/07/2023.
//
//import Foundation
//
//protocol HomeViewModelDelegate: AnyObject {
//    func didSelectRecipe(_ recipe: RecipesModel)
//}
//
//
//class HomeViewModel {
//
//    weak var delegate: HomeViewModelDelegate?
//
//    private var recipes: [RecipesModel] = []
//
//    // Function to set the recipes data in the view model
//    func setRecipes(_ recipes: [RecipesModel]) {
//        self.recipes = recipes
//    }
//
//    func getNumberOfRecipes() -> Int {
//        return recipes.count
//    }
//
//    func getRecipe(at index: Int) -> RecipesModel {
//        return recipes[index]
//    }
//
//    func didSelectRecipe(at index: Int) {
//        let selectedRecipe = recipes[index]
//        delegate?.didSelectRecipe(selectedRecipe)
//    }
//}


//    func getData() {
//            
//            APICaller.getRecipesModel{ result in
//            
//                switch result {
//                case .success(let data):
//                    print(data.count)
//                case .failure(let err):
//                    print(err)
//                }
//            }
//        }
    
//    func didSelectRecipe(at index: Int) {
//        let selectedRecipe = recipes[index]
//        delegate?.didSelectRecipe(selectedRecipe)
//    }
//}

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func didSelectRecipe(_ recipe: RecipesModel)
}

class HomeViewModel {
    var isLoadingData: Observable<Bool> = Observable(false)
    var dataSource: [RecipesModel]? // Update the type to [RecipeModel]
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
                self?.dataSource = recipes // Use dataSource directly
                self?.mapRecipeData()
            case .failure(let err):
                print(err)
            }
        }
    }

    private func mapRecipeData() {
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
        guard let selectedRecipe = getRecipe(at: index) else { return }
        delegate?.didSelectRecipe(selectedRecipe)
    }

    func retrieveRecipe(withId id: Int) -> RecipesModel? {
        return dataSource?.first { $0.id == "\(id)" }
    }
}

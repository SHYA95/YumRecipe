//
//  HomeViewModel.swift
//  Yum-Recipe
//
//  Created by Shrouk Yasser on 30/07/2023.
//

import UIKit

protocol HomeViewModelDelegate: AnyObject {
    func didSelectRecipe(_ recipe: RecipesModel)
}

class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    
    
//
//    func getNumberOfRecipes() -> Int {
//        return recipes.count
//    }
//
//    func getRecipe(at index: Int) -> RecipesModel {
//        return recipes[index]
//    }
    func getData() {
            
            APICaller.getRecipesModel{ result in
            
                switch result {
                case .success(let data):
                    print(data.count)
                case .failure(let err):
                    print(err)
                }
            }
        }
    
//    func didSelectRecipe(at index: Int) {
//        let selectedRecipe = recipes[index]
//        delegate?.didSelectRecipe(selectedRecipe)
//    }
}

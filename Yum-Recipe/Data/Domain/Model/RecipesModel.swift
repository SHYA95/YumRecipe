//
//  RecipeModel.swift
//  Yum-Recipe
//
//  Created by Shrouk Yasser on 30/07/2023.
//

import Foundation
// MARK: - RecipesModel
struct RecipesModel: Decodable {
    let id: String?
    let fats: String?
    let name: String?
    let time: String?
    let image: String?
    let weeks: [String?]?
    let carbos: String?
    let fibers: String?
    let rating: Double?
    let country: String?
    let ratings: Int?
    let calories: String?
    let headline: String?
    let keywords: [String?]?
    let products: [String?]?
    let proteins: String?
    let favorites: Int?
    let difficulty: Int?
    let description: String?
    let highlighted: Bool?
    let ingredients: [String]
    let incompatibilities: [String?]?
    let deliverableIngredients: [String?]?
    let undeliverableIngredients: [String?]?

}

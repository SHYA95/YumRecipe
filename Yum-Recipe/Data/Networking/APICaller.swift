//
//  APICaller.swift
//  Yum-Recipe
//
//  Created by Shrouk Yasser on 30/07/2023.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case canNotParseData
}

public class APICaller {
    
    static func getRecipesModel(completionHandler: @escaping (Result<[RecipesModel], Error>) -> Void) {
        if NetworkConstants.shared.accessKey.isEmpty {
            print("<!> API KEY is Missing <!>")
            print("<!> Get One from: https://api.npoint.io/ <!>")
            completionHandler(.failure(NetworkError.urlError))
            return
        }
        
        let urlString = NetworkConstants.shared.serverAddress + NetworkConstants.shared.accessKey
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(NetworkError.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let recipes = try decoder.decode([RecipesModel].self, from: data!)
                completionHandler(.success(recipes))
            } catch {
                completionHandler(.failure(NetworkError.canNotParseData))
            }
        }.resume()
    }
}

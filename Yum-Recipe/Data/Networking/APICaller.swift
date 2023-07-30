//
//  APICaller.swift
//  Yum-Recipe
//
//  Created by Shrouk Yasser on 30/07/2023.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case urlError
    case canNotParseData
}

public class APICaller {
    
    static func getRecipesModel(completionHandler: @escaping (_ result: Result<[RecipesModel], NetworkError>) -> Void) {
        if NetworkConstants.shared.accessKey.isEmpty {
            print("<!> API KEY is Missing <!>")
            print("<!> Get One from: https://www.themoviedb.org/ <!>")
            return
        }
        
        let urlString = NetworkConstants.shared.serverAddress +
                "trending/all/day?api_key=" +
                NetworkConstants.shared.accessKey
                
        guard let url = URL(string: urlString) else {
            completionHandler(Result.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, err in
            if err == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode([RecipesModel].self, from: data) {
                completionHandler(.success(resultData))
            } else {
                print(err.debugDescription)
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
}

//
//  APIConfig.swift
//  Yum-Recipe
//
//  Created by Shrouk Yasser on 30/07/2023.
//

import Foundation
//enum APIConfig {
//    static let baseUrl: String = "https://api.npoint.io"
//    static let accessKey: String = "/43427003d33f1f6b51cc"
//}


class NetworkConstants {
    
    public static var shared: NetworkConstants = NetworkConstants()
    
    public var accessKey: String {
        get {
            
            return  "/43427003d33f1f6b51cc"
        }
    }
    
    public var serverAddress: String {
        get {
            return "https://api.npoint.io"
        }
    }
    
    
}

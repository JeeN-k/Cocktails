//
//  APIScheme.swift
//  Cocktails
//
//  Created by Oleg Stepanov on 14.01.2022.
//

import Foundation

enum APIS {
    case searchCocktail
    case cocktailById
        
    func getAPI() -> APIScheme {
        switch self {
        case .searchCocktail:
            return APIScheme(path: "/api/json/v1/1/search.php")
        case .cocktailById:
            return APIScheme(path: "/api/json/v1/1/lookup.php")
        }
    }
}

struct APIScheme {
    var scheme: String
    var host: String
    var path: String
    
    init (path: String) {
        self.scheme = "https"
        self.host = "thecocktaildb.com"
        self.path = path
    }
}

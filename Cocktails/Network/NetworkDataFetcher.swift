//
//  NetworkDataFetcher.swift
//  Cocktails
//
//  Created by Oleg Stepanov on 14.01.2022.
//

import Foundation

protocol DataFetcher {
    func getSearchedCocktails(searchString: String, response: @escaping ([Drink]?) -> ())
    func getCocktailById(id: String, response: @escaping ([Drink]?) -> ())
}

class NetworkDataFetcher: DataFetcher {
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getSearchedCocktails(searchString: String, response: @escaping ([Drink]?) -> ()) {
        let params = ["s": searchString]
        let api = APIS.searchCocktail.getAPI()
        networking.getRequest(apiScheme: api, parameters: params) { data, error in
            if let error = error {
                print("Error data recieved \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJSON(type: CocktailReponse.self, from: data)
            response(decoded?.drinks)
        }
    }
    
    func getCocktailById(id: String, response: @escaping ([Drink]?) -> ()) {
        let params = ["i": id]
        let api = APIS.cocktailById.getAPI()
        networking.getRequest(apiScheme: api, parameters: params) { data, error in
            if let error = error {
                print("Error data recieved \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJSON(type: CocktailReponse.self, from: data)
            response(decoded?.drinks)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = data, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}

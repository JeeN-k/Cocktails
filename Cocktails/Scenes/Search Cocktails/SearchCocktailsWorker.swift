//
//  SearchCocktailsWorker.swift
//  Cocktails
//
//  Created by Oleg Stepanov on 14.01.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class SearchCocktailsService {
    var networking: Networking
    var fetcher: DataFetcher
    
    init() {
        self.networking = NetworkService()
        self.fetcher = NetworkDataFetcher(networking: networking)
    }
    
    func getSearchedCocktails(searchString: String, completion: @escaping ([Drink]) -> ()) {
        fetcher.getSearchedCocktails(searchString: searchString) { drinkResponse in
            guard let drinkResponse = drinkResponse else { return }
            completion(drinkResponse)
        }
    }
}

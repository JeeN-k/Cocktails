//
//  SearchCocktailsInteractor.swift
//  Cocktails
//
//  Created by Oleg Stepanov on 14.01.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchCocktailsBusinessLogic {
    func searchRequest(request: SearchCocktails.Search.Request)
    func setCocktailID(request: SearchCocktails.SelectCocktail.Request)
}

protocol SearchCocktailsDataStore {
    var id: String? { get }
}

class SearchCocktailsInteractor: SearchCocktailsBusinessLogic, SearchCocktailsDataStore {
    
    var presenter: SearchCocktailsPresentationLogic?
    var service: SearchCocktailsService?
    
    var id: String?
    
    func searchRequest(request: SearchCocktails.Search.Request) {
        if service == nil {
            service = SearchCocktailsService()
        }
        service?.getSearchedCocktails(searchString: request.searchString, completion: { drinkResponse in
            let response = SearchCocktails.Search.Response(searchedCocktails: drinkResponse)
            self.presenter?.presentData(response: response)
        })
    }
    
    func setCocktailID(request: SearchCocktails.SelectCocktail.Request) {
        self.id = request.drinkId
        let response = SearchCocktails.SelectCocktail.Response()
        presenter?.presentShowDetails(response: response)
    }
}

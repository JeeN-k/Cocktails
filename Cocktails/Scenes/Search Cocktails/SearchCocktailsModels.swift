//
//  SearchCocktailsModels.swift
//  Cocktails
//
//  Created by Oleg Stepanov on 14.01.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum SearchCocktails {
    
    enum Search {
        struct Request {
            var searchString: String
        }
        struct Response {
            var searchedCocktails: [Drink]
        }
        struct ViewModel {
            var cocktailViewModel: DrinkViewModel
        }
    }
    
    enum SelectCocktail {
        struct Request {
            var drinkId: String
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            
        }
    }
    
}

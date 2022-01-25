//
//  SearchCocktailsPresenter.swift
//  Cocktails
//
//  Created by Oleg Stepanov on 14.01.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchCocktailsPresentationLogic {
    func presentData(response: SearchCocktails.Search.Response)
    func presentShowDetails(response: SearchCocktails.SelectCocktail.Response)
}

class SearchCocktailsPresenter: SearchCocktailsPresentationLogic {
    weak var viewController: SearchCocktailsDisplayLogic?
    
    func presentData(response: SearchCocktails.Search.Response) {
        let drink = response.searchedCocktails
        let cells = drink.map { drinkItem in
            cellViewModel(from: drinkItem)
        }
        let drinkViewModel = DrinkViewModel.init(cells: cells)
        let viewModel = SearchCocktails.Search.ViewModel(cocktailViewModel: drinkViewModel)
        viewController?.displayData(viewModel: viewModel)
    }
    
    func presentShowDetails(response: SearchCocktails.SelectCocktail.Response) {
        let viewModel = SearchCocktails.SelectCocktail.ViewModel()
        viewController?.displayCocktailDetails(viewModel: viewModel)
    }
    
    private func cellViewModel(from drinkItem: Drink) -> DrinkViewModel.Cell {
        return DrinkViewModel.Cell.init(name: drinkItem.strDrink, category: drinkItem.strCategory, imageUrl: drinkItem.strDrinkThumb, id: drinkItem.idDrink)
    }
    
}

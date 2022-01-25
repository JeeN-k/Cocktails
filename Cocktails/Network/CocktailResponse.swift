//
//  CocktailResponse.swift
//  Cocktails
//
//  Created by Oleg Stepanov on 14.01.2022.
//

import Foundation

struct CocktailReponse: Codable {
    var drinks: [Drink]
}

struct Drink: Codable {
    var idDrink: String
    var strDrink: String
    var strCategory: String
    var strInstructions: String
    var strDrinkThumb: String
    var strAlcoholic: String
    var strGlass: String
    var strIngredient1: String
    var strMeasure1: String
    var strIngredient2: String
    var strMeasure2: String
}

struct DrinkViewModel {
    struct Cell: DrinkCellViewModel {
        var name: String
        var category: String
        var imageUrl: String
        var id: String
    }
    let cells: [Cell]
}

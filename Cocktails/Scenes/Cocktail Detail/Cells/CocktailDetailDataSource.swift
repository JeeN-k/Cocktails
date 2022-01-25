//
//  CocktailDetailDataSource.swift
//  Cocktails
//
//  Created by Oleg Stepanov on 17.01.2022.
//

import Foundation
import UIKit

class CocktailDetailDataSource: NSObject {
    enum CocktailSection: Int, CaseIterable {
        case image
        case name
        case category
        case alcoholic
        case glass
        case instructions
        case ingredients
        
        func cellIdentifier(for row: Int) -> String {
            switch self {
            case .image:
                return "ImageCell"
            case .name:
                return "NameCell"
            case .category:
                return "CategoryCell"
            case .alcoholic:
                return "ABVCell"
            case .glass:
                return "GlassCell"
            case .instructions:
                return "InstructuinCell"
            case .ingredients:
                return "IngredientsCell"
            }
        }
    }
    
    var drink: Drink
    
    init(drink: Drink) {
        self.drink = drink
    }
    
    static var cellIdentifier: [String] {
        var array = [String]()
        for item in CocktailSection.allCases {
            if item != .image || item != .instructions {
                array.append(item.cellIdentifier(for: item.rawValue))
            }
        }
        return array
    }
    
    private func dequeueAndConfigureCell(for indexPath: IndexPath, form tableView: UITableView) -> UITableViewCell {
        guard let section = CocktailSection(rawValue: indexPath.section) else {
            fatalError()
        }
        let identifier = section.cellIdentifier(for: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        switch section {
        case .image:
            if let imageCell = cell as? CocktailImageCell {
                imageCell.configure(with: drink.strDrinkThumb)
            }
        case .name:
            cell.textLabel?.text = drink.strDrink
        case .category:
            cell.textLabel?.text = drink.strCategory
        case .alcoholic:
            cell.textLabel?.text = drink.strAlcoholic
        case .glass:
            cell.textLabel?.text = drink.strGlass
        case .instructions:
            if let instructCell = cell as? CocktailInstructionsCell {
                instructCell.configure(with: drink.strInstructions)
            }
        case .ingredients:
            cell.textLabel?.text = "\(drink.strIngredient1)(\(drink.strMeasure1)), \(drink.strIngredient2)(\(drink.strMeasure2))"
        }
        return cell
    }
}

extension CocktailDetailDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return CocktailSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return dequeueAndConfigureCell(for: indexPath, form: tableView)
    }
}


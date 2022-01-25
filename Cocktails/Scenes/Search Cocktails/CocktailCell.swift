//
//  CocktailCell.swift
//  Cocktails
//
//  Created by Oleg Stepanov on 14.01.2022.
//

import Foundation
import UIKit

protocol DrinkCellViewModel {
    var name: String { get }
    var category: String { get }
    var imageUrl: String { get }
    var id: String { get }
}

class CocktailCell: UITableViewCell {
    static let reuseID = "CocktailCell"
    
    let cocktailImage: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    let cocktailName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cocktail name"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let cocktailCategory: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cocktail Category"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        setupConstraints()
    }
    
    func setupFields(drinkViewModel: DrinkCellViewModel) {
        cocktailName.text = drinkViewModel.name
        cocktailCategory.text = drinkViewModel.category
        cocktailImage.set(imageURL: drinkViewModel.imageUrl)
    }
    
    private func setupConstraints() {
        addSubview(cocktailImage)
        addSubview(cocktailName)
        addSubview(cocktailCategory)
        
        cocktailImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        cocktailImage.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        cocktailImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        cocktailImage.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        cocktailName.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        cocktailName.leadingAnchor.constraint(equalTo: cocktailImage.trailingAnchor, constant: 20).isActive = true
        cocktailName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        
        cocktailCategory.leadingAnchor.constraint(equalTo: cocktailImage.trailingAnchor, constant: 20).isActive = true
        cocktailCategory.topAnchor.constraint(equalTo: cocktailName.bottomAnchor, constant: 10).isActive = true
        cocktailCategory.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

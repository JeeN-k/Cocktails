//
//  CocktailImageCell.swift
//  Cocktails
//
//  Created by Oleg Stepanov on 17.01.2022.
//

import Foundation
import UIKit

class CocktailImageCell: UITableViewCell {
    let image: WebImageView = {
        let image = WebImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with url: String) {
        image.set(imageURL: url)
    }
    
    private func setupConstraints() {
        addSubview(image)
        
        image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        image.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
    }
}

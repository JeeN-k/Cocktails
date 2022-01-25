//
//  CocktailInstructionsCell.swift
//  Cocktails
//
//  Created by Oleg Stepanov on 17.01.2022.
//

import Foundation
import UIKit

class CocktailInstructionsCell: UITableViewCell {
    let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.font = UIFont.systemFont(ofSize: 15)
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        
    }
    
    func configure(with text: String) {
        textView.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(textView)
        
        textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        textView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        
    }
}

//
//  CocktailDetailWorker.swift
//  Cocktails
//
//  Created by Oleg Stepanov on 17.01.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class CocktailDetailWorker {
    var networking: Networking
    var fetcher: DataFetcher
    
    init() {
        self.networking = NetworkService()
        self.fetcher = NetworkDataFetcher(networking: networking)
    }
    
    func getCocktailById(id: String, completion: @escaping (Drink) -> ()) {
        fetcher.getCocktailById(id: id) { drinks in
            guard let drinks = drinks else { return }
            completion(drinks[0])
        }
    }
}
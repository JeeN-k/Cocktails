//
//  SearchCocktailsRouter.swift
//  Cocktails
//
//  Created by Oleg Stepanov on 14.01.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchCocktailsRoutingLogic {
    func routeToCocktailDetails(segue: UIStoryboardSegue?)
}

protocol SearchCocktailsDataPassing {
    var dataStore: SearchCocktailsDataStore? { get }
}

class SearchCocktailsRouter: NSObject, SearchCocktailsRoutingLogic, SearchCocktailsDataPassing {
    
    weak var viewController: SearchCocktailsViewController?
    var dataStore: SearchCocktailsDataStore?
    
    // MARK: Routing (navigating to other screens)
    
    func routeToCocktailDetails(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! CocktailDetailViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToCocktailDetails(source: dataStore!, destination: &destinationDS)
        } else {
            let destinationVC = CocktailDetailViewController()
            var destinationDS = destinationVC.router!.dataStore!
            passDataToCocktailDetails(source: dataStore!, destination: &destinationDS)
            navigateToCocktailDetails(source: viewController!, destination: destinationVC)
        }
    }
    
    // MARK: Navigation to other screen
    
    func navigateToCocktailDetails(source: SearchCocktailsViewController, destination: CocktailDetailViewController) {
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data to other screen
    
    func passDataToCocktailDetails(source: SearchCocktailsDataStore, destination: inout CocktailDetailDataStore) {
        destination.drinkID = source.id
    }
    
}

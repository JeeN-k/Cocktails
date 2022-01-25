//
//  SearchCocktailsViewController.swift
//  Cocktails
//
//  Created by Oleg Stepanov on 13.01.2022.
//

import UIKit

protocol SearchCocktailsDisplayLogic: AnyObject {
    func displayData(viewModel: SearchCocktails.Search.ViewModel)
    func displayCocktailDetails(viewModel: SearchCocktails.SelectCocktail.ViewModel)
}

class SearchCocktailsViewController: UIViewController, SearchCocktailsDisplayLogic {
    
    var interactor: SearchCocktailsBusinessLogic?
    var router: (NSObjectProtocol & SearchCocktailsRoutingLogic & SearchCocktailsDataPassing)?
    
    var tableView: UITableView = UITableView()
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchedDrinks: DrinkViewModel = DrinkViewModel(cells: [])
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = SearchCocktailsInteractor()
        let presenter             = SearchCocktailsPresenter()
        let router                = SearchCocktailsRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
        router.dataStore = interactor
    }
    
    // MARK: - Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Search cocktails"
        setupSearchBar()
        setupView()
    }
    
    func displayData(viewModel: SearchCocktails.Search.ViewModel) {
        searchedDrinks = viewModel.cocktailViewModel
        tableView.reloadData()
    }
    
    func displayCocktailDetails(viewModel: SearchCocktails.SelectCocktail.ViewModel) {
        router?.routeToCocktailDetails(segue: nil)
    }
    
    private func searchCocktails(searchString: String) {
        let request = SearchCocktails.Search.Request(searchString: searchString)
        interactor?.searchRequest(request: request)
    }
    
    private func showCocktailDetails(with drinkId: String) {
        let request = SearchCocktails.SelectCocktail.Request(drinkId: drinkId)
        interactor?.setCocktailID(request: request)
    }
}

extension SearchCocktailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedDrinks.cells.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CocktailCell.reuseID, for: indexPath) as! CocktailCell
        cell.setupFields(drinkViewModel: searchedDrinks.cells[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = searchedDrinks.cells[indexPath.row].id
        showCocktailDetails(with: id)
    }
}

extension SearchCocktailsViewController {
    
    private func setupView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.register(CocktailCell.self, forCellReuseIdentifier: CocktailCell.reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension SearchCocktailsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchString = searchController.searchBar.text else { return }
        guard searchString.count > 1 else {
            searchedDrinks = DrinkViewModel(cells: [])
            tableView.reloadData()
            return
        }
        searchCocktails(searchString: searchString)
    }
    
    private func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

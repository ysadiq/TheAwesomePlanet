//
//  TheAwesomePlanetViewController.swift
//  TheAwesomePlanet
//
//  Created by Yahya Saddiq on 10/18/19.
//  Copyright © 2019 Yahya Saddiq. All rights reserved.
//

import UIKit

class TheAwesomePlanetViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var viewModel: TheAwesomePlanetViewModel = {
        return TheAwesomePlanetViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initViewModel()
    }

    private func initViewModel() {
        viewModel.showAlertClosure = { [weak self] () in
            performUIUpdatesOnMain {
                if let message = self?.viewModel.alertMessage {
                    //self?.showMessagePrompt(message)
                }
            }
        }

        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.tableView.alpha = 0.0
                        self?.searchBar.alpha = 0.0
                    })
                }else {
                    self?.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.tableView.alpha = 1.0
                        self?.searchBar.alpha = 1.0
                    })
                }
            }
        }

        viewModel.reloadTableViewClosure = { [weak self] () in
            performUIUpdatesOnMain {
                self?.tableView.reloadData()
            }
        }
        viewModel.fetchCities()
    }
}

extension TheAwesomePlanetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TheAwesomePlanetCell",
                                                 for: indexPath)
        guard let cellItem = cell as? TheAwesomePlanetCell,
            let cellViewModel = viewModel.getCityCellViewModel(at: indexPath) else {
            return cell
        }

        cellItem.configure(with: cellViewModel)

        return cell
    }
}

extension TheAwesomePlanetViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText:String){
        viewModel.filterCities(searchText)
    }
}

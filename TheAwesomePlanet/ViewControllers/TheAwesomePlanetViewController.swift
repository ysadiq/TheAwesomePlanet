//
//  TheAwesomePlanetViewController.swift
//  TheAwesomePlanet
//
//  Created by Yahya Saddiq on 10/18/19.
//  Copyright © 2019 Yahya Saddiq. All rights reserved.
//

import UIKit

final class TheAwesomePlanetViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var selectedCity: CityCellViewModel?
    
    lazy var viewModel: CityViewModel = {
        return CityViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TheAwesomePlanetCityCell", bundle: nil), forCellReuseIdentifier: "TheAwesomePlanetCityCell")
        initViewModel()
    }

    private func initViewModel() {
        viewModel.showAlertClosure = { [weak self] () in
            performUIUpdatesOnMain { [weak self] in
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert(message)
                    self?.activityIndicator.stopAnimating()
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
                self?.tableView.setContentOffset(.zero, animated: true)
                self?.tableView.reloadData()
            }
        }
        viewModel.fetchCities()
    }

    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - UITableViewDataSource methods
extension TheAwesomePlanetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TheAwesomePlanetCityCell",
                                                 for: indexPath)
        guard let cellItem = cell as? TheAwesomePlanetCityCell,
            let cityCellViewModel = viewModel.getCellViewModel(at: indexPath) as? CityCellViewModel else {
            return cell
        }

        cellItem.configure(with: cityCellViewModel)
        cellItem.delegate = self

        return cell
    }
}

extension TheAwesomePlanetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let city = (viewModel.getCellViewModel(at: indexPath) as? CityCellViewModel) else {
            return nil
        }
        selectedCity = city
        return indexPath
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showMap", sender: tableView)
    }
}


extension TheAwesomePlanetViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText:String){
        viewModel.filter(searchText)
    }
}

extension TheAwesomePlanetViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let mapViewController = segue.destination as? TheAwesomePlanetMapViewController else {
            return
        }

        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        mapViewController.city = selectedCity
    }
}

extension TheAwesomePlanetViewController: TheAwesomePlanetCityCellDelegate {
    func showDetailsButtonPressed(_ cell: TheAwesomePlanetCityCell) {
        performSegue(withIdentifier: "showDetails", sender: tableView)
    }
}

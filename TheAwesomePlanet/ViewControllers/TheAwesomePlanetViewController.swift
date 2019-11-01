//
//  TheAwesomePlanetViewController.swift
//  TheAwesomePlanet
//
//  Created by Yahya Saddiq on 10/18/19.
//  Copyright © 2019 Yahya Saddiq. All rights reserved.
//

import UIKit
import MapKit

final class TheAwesomePlanetViewController: UIViewController {
    // MARK: - Properties
    var activityIndicatorView: UIActivityIndicatorView!
    var portraitView: PortraitView!
    var landscapeView: LandscapeView!

    var selectedCity: CityCellViewModel?
    lazy var viewModel: CityViewModel = CityViewModel()

    var tableView: UITableView {
        switch UIDevice.current.orientation {
        case .portrait:
            return portraitView.tableView
        case .landscapeLeft, .landscapeRight:
            return landscapeView.tableView
        default:
            return portraitView.tableView
        }
    }

    var searchBar: UISearchBar {
        switch UIDevice.current.orientation {
        case .portrait:
            return portraitView.searchBar
        case .landscapeLeft, .landscapeRight:
            return landscapeView.searchBar
        default:
            return portraitView.searchBar
        }
    }

    var _view: UIView {
        switch UIDevice.current.orientation {
        case .portrait:
            return portraitView
        case .landscapeLeft, .landscapeRight:
            return landscapeView
        default:
            return portraitView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPortriatView()
        initLandsacpeView()
        initActivityIndicatorView()
        initViewModel()
    }

    private func initPortriatView() {
        guard let pView = UINib(nibName: "Portrait", bundle: .main).instantiate(withOwner: nil, options: nil).first as? PortraitView else {
            return
        }
        portraitView = pView
        portraitView.frame = CGRect(origin: CGPoint.zero, size: view.frame.size)

        portraitView.tableView.delegate = self
        portraitView.tableView.dataSource = self
        portraitView.searchBar.delegate = self

        portraitView.tableView.register(UINib(nibName: "TheAwesomePlanetCityCell", bundle: nil), forCellReuseIdentifier: "TheAwesomePlanetCityCell")

        portraitView.alpha = 0
        view.addSubview(portraitView)
    }

    private func initLandsacpeView() {
        guard let lView = UINib(nibName: "Landscape", bundle: .main).instantiate(withOwner: nil, options: nil).first as? LandscapeView else {
            return
        }
        landscapeView = lView
        landscapeView.frame = CGRect(origin: CGPoint.zero, size: view.frame.size)

        landscapeView.tableView.delegate = self
        landscapeView.tableView.dataSource = self
        landscapeView.searchBar.delegate = self

        landscapeView.tableView.register(UINib(nibName: "TheAwesomePlanetCityCell", bundle: nil), forCellReuseIdentifier: "TheAwesomePlanetCityCell")

        landscapeView.alpha = 0
        view.addSubview(landscapeView)
    }

    func initViewModel() {
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async { [weak self] in
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert(message)
                    self?.activityIndicatorView.stopAnimating()
                }
            }
        }

        viewModel.updateLoadingStatus = { [weak self] () in
            guard let self = self else {
                return
            }

            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                switch self.viewModel.state {
                case .empty, .error:
                    self.activityIndicatorView.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self._view.alpha = 0.0
                    })
                case .loading:
                    self.activityIndicatorView.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self._view.alpha = 0.0
                    })
                case .populated, .populatedWithFilter:
                    self.activityIndicatorView.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self._view.alpha = 1.0
                    })
                case .searching:
                    self.activityIndicatorView.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self._view.alpha = 0.1
                    })
                }
            }
        }

        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.setContentOffset(.zero, animated: true)
                self?.tableView.reloadData()
            }
        }
        viewModel.fetchCities()
    }

    private func initActivityIndicatorView() {
        activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicatorView.color = .black
        activityIndicatorView.center = self.view.center
        view.addSubview(activityIndicatorView)
    }

    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        switch UIDevice.current.orientation {
        case .landscapeLeft, .landscapeRight:
            navigationController?.isToolbarHidden = true
            self.view.layoutIfNeeded()

            UIView.animate(withDuration: 0.1) { [weak self] in
                self?.portraitView.alpha = 0
                self?.landscapeView.searchBar.text = self?.portraitView.searchBar.text
                self?.landscapeView.alpha = 1
                self?.tableView.reloadData()
            }
        default:
            UIView.animate(withDuration: 0.1) { [weak self] in
                self?.landscapeView.alpha = 0
                self?.portraitView.searchBar.text = self?.landscapeView.searchBar.text
                self?.portraitView.alpha = 1
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: TheAwesomePlanetViewController Segue
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

// MARK: TheAwesomePlanetCityCell Delegate

extension TheAwesomePlanetViewController: TheAwesomePlanetCityCellDelegate {
    func showDetailsButtonPressed(_ cell: TheAwesomePlanetCityCell) {
//        performSegue(withIdentifier: "showDetails", sender: tableView)
    }
}

// MARK: TableView Datasource

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

// MARK: TableView Delegate

extension TheAwesomePlanetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let city = (viewModel.getCellViewModel(at: indexPath) as? CityCellViewModel) else {
            return nil
        }
        selectedCity = city
        return indexPath
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch UIDevice.current.orientation {
        case .landscapeLeft, .landscapeRight:
            guard let selectedCity = selectedCity else {
                return
            }
            landscapeView.configureMapView(selectedCity)
        default:
            performSegue(withIdentifier: "showMap", sender: tableView)
        }

    }
}


// MARK: UISearchBar Delegate

extension TheAwesomePlanetViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText:String){
        viewModel.filter(searchText)
    }
}

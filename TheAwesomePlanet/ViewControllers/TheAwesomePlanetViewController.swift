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
    var activityIndicator: UIActivityIndicatorView!
    var portraitView: PortraitView!
    var landscapeView: LandscapeView!

    var selectedCity: CityCellViewModel?
    lazy var viewModel: CityViewModel = {
        return CityViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initPortriatView()
        initLandsacpeView()
        initActivityIndicatory()
        initViewModel()
    }

    private func initActivityIndicatory() {
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.color = .black
        activityIndicator.center = self.view.center
        view.addSubview(activityIndicator)
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
                        self?._view.alpha = 0.0
                    })
                }else {
                    self?.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?._view.alpha = 1.0
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

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            navigationController?.isToolbarHidden = true
            self.view.layoutIfNeeded()

            UIView.animate(withDuration: 0.1) { [weak self] in
                self?.portraitView.alpha = 0
                self?.landscapeView.alpha = 1
                self?.tableView.reloadData()
            }
        } else {
            UIView.animate(withDuration: 0.1) { [weak self] in
                self?.landscapeView.alpha = 0
                self?.portraitView.alpha = 1
                self?.tableView.reloadData()
            }
        }
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

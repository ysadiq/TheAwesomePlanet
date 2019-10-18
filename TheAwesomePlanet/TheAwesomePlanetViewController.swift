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
            performUIUpdatesOnMain {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    //self?.showSpinner()
                } else {
                    //self?.hideSpinner()
                }
            }
        }

        viewModel.reloadTableViewClosure = { [weak self] () in

            let offset = self?.tableView.contentOffset

            performUIUpdatesOnMain {
                self?.tableView.reloadData()
                self?.tableView.layoutIfNeeded()  // Force layout so things are updated before resetting the contentOffset.
                self?.tableView.setContentOffset(offset!, animated: false)
            }
        }
        viewModel.fetchCities()
    }
}

extension TheAwesomePlanetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfCells
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}


//
//  TheAwesomePlanetAboutViewController.swift
//  TheAwesomePlanet
//
//  Created by Yahya Saddiq on 10/19/19.
//  Copyright © 2019 Yahya Saddiq. All rights reserved.
//

import Foundation
import UIKit

// MARK: - AboutViewController implementation
final class TheAwesomePlanetAboutViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet var tableView: UITableView!
    let activityIndicatorView = UIActivityIndicatorView(style: .gray)
    lazy var viewModel: AboutInfoViewModel = {
        return AboutInfoViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.titleView = activityIndicatorView
        activityIndicatorView.hidesWhenStopped = true
        initViewModel()
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

            DispatchQueue.main.async {
                switch self.viewModel.state {
                case .empty, .error:
                    self.activityIndicatorView.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.tableView.alpha = 0.0
                    })
                case .loading:
                    self.activityIndicatorView.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.tableView.alpha = 0.0
                    })
                case .populated:
                    self.activityIndicatorView.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.tableView.alpha = 1.0
                    })
                default:
                    break
                }
            }
        }

        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.fetchAboutInfo()
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
extension TheAwesomePlanetAboutViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TheAwesomePlanetAboutInfoCell",
                                                 for: indexPath)
        guard let cellItem = cell as? TheAwesomePlanetAboutInfoCell,
            let aboutInfoCellViewModel = viewModel.getCellViewModel(at: indexPath) as? AboutInfoCellViewModel else {
                return cell
        }

        cellItem.configure(with: aboutInfoCellViewModel)
        return cell
    }
}

//
//  ViewController+TableView.swift
//  TheAwesomePlanet
//
//  Created by Yahya Saddiq on 10/21/19.
//  Copyright © 2019 Yahya Saddiq. All rights reserved.
//

import Foundation
import UIKit

extension TheAwesomePlanetViewController {
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

}

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
        guard UIDevice.current.orientation.isPortrait else {
            return
        }
        performSegue(withIdentifier: "showMap", sender: tableView)
    }
}

//
//  TheAwesomePlanetCityCell.swift
//  TheAwesomePlanet
//
//  Created by Yahya Saddiq on 10/18/19.
//  Copyright © 2019 Yahya Saddiq. All rights reserved.
//

import Foundation
import UIKit

class TheAwesomePlanetCityCell: UITableViewCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var subTitle: UILabel!
    @IBOutlet var showDetailsButton: UIButton!
    var delegate: TheAwesomePlanetCityCellDelegate?

    func configure(with cityCellViewModel: CityCellViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.title.text = "\(cityCellViewModel.name), \(cityCellViewModel.country)"
            self?.subTitle.text = "\(cityCellViewModel.coordinate.lat), \(cityCellViewModel.coordinate.lon)"
            self?.showDetailsButton.setTitle("Discover \(cityCellViewModel.name)",for: .normal)
            self?.showDetailsButton.layer.cornerRadius = 4
        }
    }

    @IBAction func showDetailsButtonPressed() {
        delegate?.showDetailsButtonPressed(self)
    }
}

// MARK: - TheAwesomePlanetCity Cell Delegate Protocol
protocol TheAwesomePlanetCityCellDelegate {
    func showDetailsButtonPressed(_ cell: TheAwesomePlanetCityCell)
}

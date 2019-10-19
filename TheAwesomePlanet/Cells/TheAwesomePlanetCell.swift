//
//  TheAwesomePlanetCell.swift
//  TheAwesomePlanet
//
//  Created by Yahya Saddiq on 10/18/19.
//  Copyright © 2019 Yahya Saddiq. All rights reserved.
//

import Foundation
import UIKit

class TheAwesomePlanetCell: UITableViewCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var subTitle: UILabel!
    @IBOutlet var showDetail: UIButton!

    func configure(with cityCellViewModel: CityCellViewModel) {
        performUIUpdatesOnMain { [weak self] in
            self?.title.text = "\(cityCellViewModel.name), \(cityCellViewModel.country)"
            self?.subTitle.text = "\(cityCellViewModel.coordinate.lat), \(cityCellViewModel.coordinate.lon)"
            self?.showDetail.setTitle("Discover \(cityCellViewModel.name)",for: .normal)
            self?.showDetail.layer.cornerRadius = 4
        }
    }
}

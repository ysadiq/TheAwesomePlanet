//
//  TheAwesomePlanetAboutInfoCell.swift
//  TheAwesomePlanet
//
//  Created by Yahya Saddiq on 10/19/19.
//  Copyright © 2019 Yahya Saddiq. All rights reserved.
//

import Foundation
import UIKit

class TheAwesomePlanetAboutInfoCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!

    func configure(with aboutInfoCellViewModel: AboutInfoCellViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.titleLabel.text = aboutInfoCellViewModel.field
        }
    }
}

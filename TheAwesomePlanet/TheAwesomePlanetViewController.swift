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
    lazy var viewModel: TheAwesomePlanetViewModel = {
        return TheAwesomePlanetViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.fetchCities()
    }


}


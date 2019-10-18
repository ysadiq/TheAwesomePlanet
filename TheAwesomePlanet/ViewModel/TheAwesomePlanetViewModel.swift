//
//  TheAwesomePlanetViewModel.swift
//  TheAwesomePlanet
//
//  Created by Yahya Saddiq on 10/18/19.
//  Copyright © 2019 Yahya Saddiq. All rights reserved.
//

import Foundation

class TheAwesomePlanetViewModel {
    let dataManager: DataProvider

    init(dataManager: DataProvider = DataProvider()) {
        self.dataManager = dataManager
    }

    func fetchCities() {
        dataManager.getCities { (cities, error) in
            guard let cities = cities else {
                return
            }
            print(cities)
        }
    }
}

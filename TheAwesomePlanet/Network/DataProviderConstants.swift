//
//  DataProviderConstants.swift
//  TheAwesomePlanet
//
//  Created by Yahya Saddiq on 10/18/19.
//  Copyright © 2019 Yahya Saddiq. All rights reserved.
//

import Foundation

extension DataProvider {
    // MARK: Constants
    struct Constants {
        // MARK: API Key
        static let citiesAPIURL = Bundle.main.url(forResource: "cities", withExtension: "json")
        static let citiesShortListAPIURL = Bundle.main.url(forResource: "cities(short)", withExtension: "json")
    }
}

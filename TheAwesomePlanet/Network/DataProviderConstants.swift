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
        struct API {
            static let cities = Bundle.main.url(forResource: "cities", withExtension: "json")
            static let citiesShort = Bundle.main.url(forResource: "cities(short)", withExtension: "json")
            static let aboutInfo = Bundle.main.url(forResource: "aboutInfo", withExtension: "json")
        }
    }
}

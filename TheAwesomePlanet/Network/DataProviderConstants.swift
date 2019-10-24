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
            static var citiesFileName: String {
                #if DEBUG
                return "cities-Debug"
                #elseif TEST
                return "cities-Test"
                #elseif RELEASE
                return "cities-Release"
                #else
                return "config flag not found"
                #endif
            }

            static var aboutInfoFileName: String {
                return "aboutInfo"
            }

            static let cities = Bundle.main.url(forResource: citiesFileName, withExtension: "json")
            static let aboutInfo = Bundle.main.url(forResource: aboutInfoFileName, withExtension: "json")
        }
    }
}

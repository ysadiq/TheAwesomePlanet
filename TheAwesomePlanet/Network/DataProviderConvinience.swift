//
//  DataProviderConvinience.swift
//  TheAwesomePlanet
//
//  Created by Yahya Saddiq on 10/18/19.
//  Copyright © 2019 Yahya Saddiq. All rights reserved.
//

import Foundation
extension DataProvider {
    // MARK: Cities (GET) Methods
    func getCities(completionHandlerForCities: @escaping (_ result: [City]?, _ error : NSError?) -> Void) {

        guard let citiesAPI = Constants.citiesAPI else {
            return
        }
        
        let _ = taskForGETMethod(citiesAPI) { (data, error) in
            guard error == nil,
                let data = data else {
                    return
            }

            do {
                let cities: [City] = try JSONDecoder().decode([City].self, from: data)
                completionHandlerForCities(cities, nil)
            } catch(let error) {
                print("\(error)")
            }
        }
    }
}

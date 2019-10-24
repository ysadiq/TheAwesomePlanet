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
        guard let citiesAPI = Constants.API.cities else {
            let userInfo = [NSLocalizedDescriptionKey : "bad request"]
            completionHandlerForCities(nil, NSError(domain: "getCities", code: 1, userInfo: userInfo))
            return
        }
        
        let _ = taskForGETMethod(citiesAPI) { (data, error) in
            guard error == nil,
                let data = data else {
                    completionHandlerForCities(nil, error)
                    return
            }

            do {
                let cities: [City] = try JSONDecoder().decode([City].self, from: data)
                completionHandlerForCities(cities, nil)
            } catch(let error) {
                let userInfo = [NSLocalizedDescriptionKey : error.localizedDescription]
                completionHandlerForCities(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
        }
    }

    // MARK: AboutInfo (GET) Methods
    func getAboutInfo(completionHandlerForAboutInfo: @escaping (_ result: AboutInfo?, _ error : NSError?) -> Void) {
        guard let aboutInfoAPI = Constants.API.aboutInfo else {
            let userInfo = [NSLocalizedDescriptionKey : "bad request"]
            completionHandlerForAboutInfo(nil, NSError(domain: "getAboutInfo", code: 1, userInfo: userInfo))
            return
        }

        let _ = taskForGETMethod(aboutInfoAPI) { (data, error) in
            guard error == nil,
                let data = data else {
                    completionHandlerForAboutInfo(nil, error)
                    return
            }

            do {
                let aboutInfo: AboutInfo = try JSONDecoder().decode(AboutInfo.self, from: data)
                completionHandlerForAboutInfo(aboutInfo, nil)
            } catch(let error) {
                let userInfo = [NSLocalizedDescriptionKey : error.localizedDescription]
                completionHandlerForAboutInfo(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
        }
    }
}

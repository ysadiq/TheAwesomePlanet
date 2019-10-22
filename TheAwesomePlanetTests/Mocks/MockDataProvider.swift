//
//  MockDataProvider.swift
//  TheAwesomePlanetTests
//
//  Created by Yahya Saddiq on 10/21/19.
//  Copyright © 2019 Yahya Saddiq. All rights reserved.
//

import Foundation
@testable import TheAwesomePlanet

class MockDataProvider: DataProviderProtocol {
    var taskForGETMethodIsCalled: Bool = false
    var getCitiesIsCalled: Bool = false
    var getAboutInfoIsCalled: Bool = false

    static func sharedInstance() -> DataProviderProtocol {
        struct Singleton {
            static var sharedInstance = MockDataProvider()
        }
        return Singleton.sharedInstance
    }
    
    func taskForGETMethod(_ url: URL, parameters: [String : Any]?, completionHandlerForGET: @escaping (Data?, NSError?) -> Void) -> URLSessionDataTask? {
        taskForGETMethodIsCalled = true
        return nil
    }
    
    func getCities(completionHandlerForCities: @escaping ([City]?, NSError?) -> Void) {
        getCitiesIsCalled = true
    }
    
    func getAboutInfo(completionHandlerForAboutInfo: @escaping (AboutInfo?, NSError?) -> Void) {
        getAboutInfoIsCalled = true
    }
    
    
}

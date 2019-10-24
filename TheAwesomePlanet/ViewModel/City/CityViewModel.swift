//
//  CityViewModel.swift
//  TheAwesomePlanet
//
//  Created by Yahya Saddiq on 10/19/19.
//  Copyright © 2019 Yahya Saddiq. All rights reserved.
//

import Foundation

class CityViewModel: TheAwesomePlanetViewModel {
    func fetchCities(_ completionForFetchCities: ((_ status: Bool, _ error: Error?) -> Void)? = nil) {
        state = .loading
        dataManager.getCities {[weak self] (cities, error) in
            guard let self = self else {
                return
            }
            guard error == nil,
                let cities = cities else {
                    self.alertMessage = error?.localizedDescription
                    self.state = .error
                    if let completionForFetchCities = completionForFetchCities {
                        completionForFetchCities(false, error)
                    }
                    return
            }
            self.processFetchedCities(self.sort(cities))
            if let completionForFetchCities = completionForFetchCities {
                completionForFetchCities(true, nil)
            }
        }
    }

    private func sort(_ cities: [City]) -> [City] {
        return cities.sorted(by: { $0.name! < $1.name! })
    }

    private func processFetchedCities(_ cities: [City]) {
        var vms = [CityCellViewModel]()
        for city in cities {
            guard let cityCellViewModel = createCityCellViewModel(city) else {
                continue
            }
            vms.append(cityCellViewModel)
        }
        cellViewModels = vms
    }

    private func createCityCellViewModel(_ city: City) -> CityCellViewModel? {
        guard let name = city.name,
            let country = city.country,
            let coord = city.coordinate else {
                return nil
        }

        return CityCellViewModel(name: name,
                                 country: country,
                                 coordinate: coord)
    }

    func filter(_ searchText: String) {
        super.filter(searchText)
    }

    override func filter(_ searchText: String,_ cityCellViewModel: CellViewModelProtocol? = nil) -> Bool {
        guard let cityCellViewModel = cityCellViewModel as? CityCellViewModel else {
            return false
        }
        return cityCellViewModel.name.lowercased().starts(with: searchText.lowercased())
    }
}

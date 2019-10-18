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
    private var cellViewModels: [CityCellViewModel] = [CityCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }

    // callback for interfaces
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }

    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }

    var numberOfCells: Int {
        return cellViewModels.count
    }

    // interfaces
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?

    init(dataManager: DataProvider = DataProvider()) {
        self.dataManager = dataManager
    }

    func fetchCities() {
        self.isLoading = true
        dataManager.getCities {[weak self] (cities, error) in
            guard error == nil,
                let cities = cities else {
                    self?.alertMessage = error?.localizedDescription
                    return
            }

            guard let self = self else {
                return
            }
            self.processFetchedCities(self.sortCities(cities))
            self.isLoading = false
        }
    }

    private func sortCities(_ cities: [City]) -> [City] {
        return cities.sorted(by: { $0.name! < $1.name! })
    }
    func getCityCellViewModel(at indexPath: IndexPath) -> CityCellViewModel? {
        guard indexPath.row < numberOfCells else {
            return nil
        }
        return cellViewModels[indexPath.row]
    }

    private func processFetchedCities(_ cities: [City]) {
        var vms = [CityCellViewModel]()
        for city in cities {
            guard let cityCellViewModel = createCellViewModel(city) else {
                continue
            }
            vms.append(cityCellViewModel)
        }
        self.cellViewModels = vms
    }

    private func createCellViewModel(_ city: City) -> CityCellViewModel? {
        guard let name = city.name,
            let country = city.country,
            let coord = city.coordinate else {
                return nil
        }

        return CityCellViewModel(name: name,
                                 country: country,
                                 coordinate: coord)
    }
}

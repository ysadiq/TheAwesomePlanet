//
//  TheAwesomePlanetViewModel.swift
//  TheAwesomePlanet
//
//  Created by Yahya Saddiq on 10/18/19.
//  Copyright © 2019 Yahya Saddiq. All rights reserved.
//

import Foundation

protocol CellViewModelProtocol {
//    func createCityCellViewModel(_ city: City) -> CellViewModelProtocol?
}

class TheAwesomePlanetViewModel {
    let dataManager: DataProviderProtocol
    var cellViewModels: [CellViewModelProtocol] = [CellViewModelProtocol]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }

    var filteredCellViewModels: [CellViewModelProtocol] = [CellViewModelProtocol]() {
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
        return isFiltering ? filteredCellViewModels.count : cellViewModels.count
    }
    var isFiltering: Bool = false

    // interfaces
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?

    init(dataManager: DataProviderProtocol = DataProvider()) {
        self.dataManager = dataManager
    }

    func getCellViewModel(at indexPath: IndexPath) -> CellViewModelProtocol? {
        guard indexPath.row < numberOfCells else {
            return nil
        }
        return isFiltering ? filteredCellViewModels[indexPath.row] : cellViewModels[indexPath.row]
    }

    @discardableResult
    func filter(_ searchText: String,_ cityCell: CellViewModelProtocol? = nil) -> Bool {
        guard searchText != "" else {
            isFiltering = false
            reloadTableViewClosure?()
            return false
        }
        isFiltering = true
        filteredCellViewModels = cellViewModels.filter {
            return filter(searchText, $0)
        }
        
        return false
    }
}

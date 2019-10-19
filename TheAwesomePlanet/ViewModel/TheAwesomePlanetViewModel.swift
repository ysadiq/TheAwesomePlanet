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
    let dataManager: DataProvider
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
        return isFiltering() ? filteredCellViewModels.count : cellViewModels.count
    }

    // interfaces
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?

    init(dataManager: DataProvider = DataProvider()) {
        self.dataManager = dataManager
    }

    func getCellViewModel(at indexPath: IndexPath) -> CellViewModelProtocol? {
        guard indexPath.row < numberOfCells else {
            return nil
        }
        return isFiltering() ? filteredCellViewModels[indexPath.row] : cellViewModels[indexPath.row]
    }

    func isFiltering() -> Bool {
        return filteredCellViewModels.count > 0 && filteredCellViewModels.count != cellViewModels.count
    }

    @discardableResult
    func filter(_ searchText: String,_ cityCell: CellViewModelProtocol? = nil) -> Bool {
        if searchText != "" {
            filteredCellViewModels = cellViewModels.filter {
                return filter(searchText, $0)
            }
        } else {
            filteredCellViewModels = cellViewModels
        }
        return false
    }
}

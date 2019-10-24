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
            state = .populated
            self.reloadTableViewClosure?()
        }
    }

    var filteredCellViewModels: [CellViewModelProtocol] = [CellViewModelProtocol]() {
        didSet {
            state = .populatedWithFilter
            self.reloadTableViewClosure?()
        }
    }

    // callback for interfaces
    var state: State = .empty {
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
        return state == .populatedWithFilter ? filteredCellViewModels.count : cellViewModels.count
    }

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
        return state == .populatedWithFilter ? filteredCellViewModels[indexPath.row] : cellViewModels[indexPath.row]
    }

    @discardableResult
    func filter(_ searchText: String,_ cityCell: CellViewModelProtocol? = nil) -> Bool {
        state = .searching
        guard searchText != "" else {
            state = .populated
            reloadTableViewClosure?()
            return false
        }

        filteredCellViewModels = cellViewModels.filter {
            return filter(searchText, $0)
        }
        
        return false
    }
}

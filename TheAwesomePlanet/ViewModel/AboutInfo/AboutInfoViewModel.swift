//
//  AboutInfoViewModel.swift
//  TheAwesomePlanet
//
//  Created by Yahya Saddiq on 10/19/19.
//  Copyright © 2019 Yahya Saddiq. All rights reserved.
//

import Foundation

class AboutInfoViewModel: TheAwesomePlanetViewModel {
    func fetchAboutInfo() {
        isLoading = true
        dataManager.getAboutInfo {[weak self] (aboutInfo, error) in
            guard let self = self else {
                return
            }
            guard error == nil,
                let aboutInfo = aboutInfo else {
                    self.alertMessage = error?.localizedDescription
                    return
            }
            self.processFetchedAboutInfo(aboutInfo)
            self.isLoading = false
        }
    }

    private func sort(_ cities: [City]) -> [City] {
        return cities.sorted(by: { $0.name! < $1.name! })
    }

    private func processFetchedAboutInfo(_ aboutInfo: AboutInfo) {
        cellViewModels = [createAboutInfoCellViewModel(aboutInfo.companyName),
                          createAboutInfoCellViewModel(aboutInfo.companyAddress),
                          createAboutInfoCellViewModel(aboutInfo.city),
                          createAboutInfoCellViewModel(aboutInfo.postalCode),
                          createAboutInfoCellViewModel(aboutInfo.details)]
    }

    private func createAboutInfoCellViewModel(_ field: String) -> AboutInfoCellViewModel {
        return AboutInfoCellViewModel(field: field)
    }
}

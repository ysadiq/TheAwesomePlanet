//
//  AboutInfoViewModel.swift
//  TheAwesomePlanet
//
//  Created by Yahya Saddiq on 10/19/19.
//  Copyright © 2019 Yahya Saddiq. All rights reserved.
//

import Foundation

class AboutInfoViewModel: TheAwesomePlanetViewModel {
    func fetchAboutInfo(_ completionForFetchAboutInfo: ((_ status: Bool, _ error: Error?) -> Void)? = nil) {
        state = .loading
        dataManager.getAboutInfo {[weak self] (aboutInfo, error) in
            guard let self = self else {
                return
            }
            guard error == nil,
                let aboutInfo = aboutInfo else {
                    self.alertMessage = error?.localizedDescription
                    self.state = .error
                    if let completionForFetchAboutInfo = completionForFetchAboutInfo {
                        completionForFetchAboutInfo(false, error)
                    }
                    return
            }
            self.processFetchedAboutInfo(aboutInfo)
            if let completionForFetchAboutInfo = completionForFetchAboutInfo {
                completionForFetchAboutInfo(true, nil)
            }
        }
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

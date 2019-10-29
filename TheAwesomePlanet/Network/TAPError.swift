//
//  TAPError.swift
//  TheAwesomePlanet
//
//  Created by Yahya Saddiq on 10/29/19.
//  Copyright © 2019 Yahya Saddiq. All rights reserved.
//

import Foundation

public enum TAPError: Error {
    case parse
    case network
    case fileNotFound
    case empty

    var localizedDescription: String {
        switch self {
        case .parse:
            return "Parsing Failed"
        case .network:
            return "Network Error"
        case .fileNotFound:
            return "File Not Found"
        case .empty:
            return "No data"
        }
    }
}

//
//  City.swift
//  TheAwesomePlanet
//
//  Created by Yahya Saddiq on 10/18/19.
//  Copyright © 2019 Yahya Saddiq. All rights reserved.
//

import Foundation
import CoreLocation

class City: Decodable {

    var id: Int?
    var country: String?
    var name: String?
    var coordinate: Coordinate?

    struct Coordinate: Codable {
        var lat: Double
        var lon: Double
    }

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case country
        case name
        case coordinate = "coord"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        coordinate = try values.decodeIfPresent(Coordinate.self, forKey: .coordinate)
    }
}

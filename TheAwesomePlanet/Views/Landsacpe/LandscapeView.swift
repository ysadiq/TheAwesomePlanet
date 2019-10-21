//
//  LandscapeView.swift
//  TheAwesomePlanet
//
//  Created by Yahya Saddiq on 10/21/19.
//  Copyright © 2019 Yahya Saddiq. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class LandscapeView: UIView {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var searchBar: UISearchBar!
    var annotation: MKPointAnnotation!

    func configureMapView(_ city: CityCellViewModel) {
        if mapView.annotations.count > 0 {
            mapView.removeAnnotation(annotation)
        }

        let cityCoordinate = CLLocationCoordinate2D(latitude: city.coordinate.lat,
                                                    longitude: city.coordinate.lon)
        mapView.setCenter(cityCoordinate, animated: true)

        annotation = MKPointAnnotation()
        annotation.title = city.name
        annotation.coordinate = cityCoordinate
        mapView.addAnnotation(annotation)
    }
}

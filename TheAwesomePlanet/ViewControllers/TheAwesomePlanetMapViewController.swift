//
//  MapViewController.swift
//  TheAwesomePlanet
//
//  Created by Yahya Saddiq on 10/19/19.
//  Copyright © 2019 Yahya Saddiq. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class TheAwesomePlanetMapViewController: UIViewController {
    var city: CityCellViewModel?
    @IBOutlet var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapView()
    }

    private func configureMapView() {
        guard let city = city else {
            return
        }

        let cityCoordinate = CLLocationCoordinate2D(latitude: city.coordinate.lat,
                                                    longitude: city.coordinate.lon)
        mapView.setCenter(cityCoordinate, animated: true)

        let annotation = MKPointAnnotation()
        annotation.title = city.name
        annotation.coordinate = cityCoordinate
        mapView.addAnnotation(annotation)
    }
    
}

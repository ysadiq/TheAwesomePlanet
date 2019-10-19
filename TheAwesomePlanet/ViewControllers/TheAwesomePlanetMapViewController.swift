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

final class TheAwesomePlanetMapViewController: UIViewController {
    var city: CityCellViewModel?
    var annotation: MKPointAnnotation?
    @IBOutlet var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    private func configureMapView() {
        guard let city = city else {
            return
        }

        let cityCoordinate = CLLocationCoordinate2D(latitude: city.coordinate.lat,
                                                    longitude: city.coordinate.lon)
        mapView.setCenter(cityCoordinate, animated: true)

        annotation = MKPointAnnotation()
        annotation?.title = city.name
        annotation?.coordinate = cityCoordinate
    }
}

extension TheAwesomePlanetMapViewController: MKMapViewDelegate {
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        if let annotation = annotation {
            mapView.addAnnotation(annotation)
            mapView.selectAnnotation(annotation, animated: true)
        }
    }
}

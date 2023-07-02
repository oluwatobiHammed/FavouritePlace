//
//  LocationManager.swift
//  FavouritePlace
//
//  Created by Oladipupo Oluwatobi on 02/07/2023.
//

import Foundation
import CoreLocation
import MapKit


class LocationManager: ObservableObject {
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(center: LocationManager.pointNemo, latitudinalMeters: 5000, longitudinalMeters: 5000)
    
    func getLocationFor(address: String) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { [weak self] placeMarks, error in
            guard let placeMarks, let location = placeMarks.last?.location else {return}
            self?.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        }
    }
}


extension LocationManager {
    static var pointNemo: CLLocationCoordinate2D  {
        CLLocationCoordinate2D(latitude: 48.876667, longitude: -123.393333)
    }
}

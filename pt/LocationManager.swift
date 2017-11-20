//
//  LocationManager.swift
//  pt
//
//  Created by Ilias Basha on 11/20/17.
//  Copyright © 2017 Sohail. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    var coreLocationManager: CLLocationManager!
    var currentLocation: CLLocation?
    
    func start() {
        coreLocationManager = CLLocationManager()
        coreLocationManager.delegate = self
        coreLocationManager.requestWhenInUseAuthorization()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            coreLocationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            currentLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
        coreLocationManager.stopUpdatingLocation()
    }
}

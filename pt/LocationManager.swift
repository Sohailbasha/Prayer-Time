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
    
    static let sharedInstance = LocationManager()
    var coreLocationManager: CLLocationManager!
    var currentLocation: CLLocation?
    
    func start() {
        coreLocationManager = CLLocationManager()
        coreLocationManager.delegate = self
        coreLocationManager.startUpdatingLocation()
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
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("need permission to update location")
    }
    
    func locationString(completion:@escaping (_ location: String) -> Void) {
        let defaultLocation = "New York"
        let geocoder = CLGeocoder()
        guard let currentLocation = currentLocation else {
            print("currentLocation is nil. Using New York as Default")
            completion(defaultLocation)
            return
        }
        
        geocoder.reverseGeocodeLocation(currentLocation) { (placemarks, error) in
            if let error = error {
                print("error reversegeocoding: \(error)")
            }
            
            if let placemarks = placemarks {
                let placemark = placemarks[0] as CLPlacemark
                
                if let administrativeArea = placemark.administrativeArea {
                    print(administrativeArea)
                    completion(administrativeArea)
                }
            }
        }
    }
}

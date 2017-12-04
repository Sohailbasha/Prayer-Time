//
//  TutorialViewController.swift
//  pt
//
//  Created by Ilias Basha on 11/21/17.
//  Copyright © 2017 Sohail. All rights reserved.
//

import UIKit
import MapKit

class TutorialViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, LocationManagerDelegate {

    var coreLocationManager = CLLocationManager()
    var locationManager = LocationManager.sharedInstance
    var location: CLLocation!
    
    func locationFound(_ latitude: Double, longitude: Double) {
        location = CLLocation(latitude: latitude, longitude: longitude)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        coreLocationManager.delegate = self
        locationManager.delegate = self
        setupViews()
        
        let authorizationCode = CLLocationManager.authorizationStatus()
        
        if authorizationCode == CLAuthorizationStatus.notDetermined && coreLocationManager.responds(to: #selector(CLLocationManager.requestAlwaysAuthorization)) || coreLocationManager.responds(to: #selector(CLLocationManager.requestWhenInUseAuthorization)) {
            coreLocationManager.requestWhenInUseAuthorization()
        } else {
            getLocation()
        }
    }
    
    func addAction(gestureRecognizer: UIGestureRecognizer) {
        let touchPoint = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
    }
    
    func getLocation() {
        LocationManager.sharedInstance.startUpdatingLocationWithCompletionHandler { (longitude, latitude, status, verboseMessage, error) in
            self.displayLocation(location: CLLocation(latitude: latitude, longitude: longitude))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .notDetermined || status != .denied || status != .restricted {
            getLocation()
        }
    }
    
    func displayLocation(location: CLLocation) {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        mapView.setRegion(region, animated: true)
        
        let locationPinCoordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationPinCoordinate
        
        mapView.addAnnotation(annotation)
        mapView.showAnnotations([annotation], animated: true)
    }
    
    
    
    func setupViews() {
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0.6189187169, blue: 0.9825027585, alpha: 1)
        self.view.addSubview(welcomeLabel)
        completeButton.frame.origin.y = self.view.frame.height - 50
        self.view.addSubview(completeButton)
        mapView.center = self.view.center
        self.view.addSubview(mapView)
    }
    
    let mapView: MKMapView = {
        let map = MKMapView()
        map.layer.cornerRadius = 10
        map.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - UIScreen.main.bounds.width * 0.10, height: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.45)
        return map
    }()
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: UIScreen.main.bounds.height * 0.05, width: UIScreen.main.bounds.width, height: 150)
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.text = "To recieve accurate prayer times, \nplease enter your city or state"
        return label
    }()
    
    let completeButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
        button.backgroundColor = .white
        button.setTitle("Complete", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.01515489072, green: 0.6201876402, blue: 0.9830837846, alpha: 1), for: .normal)
        return button
    }()
    
    let locationTextField: UITextField = {
        let textField = UITextField()
        textField.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 100, height: 50)
        return textField
    }()
    
}

protocol Locatable {
    func didLocateSuccessfully()
}













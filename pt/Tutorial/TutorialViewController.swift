//
//  TutorialViewController.swift
//  pt
//
//  Created by Ilias Basha on 11/21/17.
//  Copyright © 2017 Sohail. All rights reserved.
//

import UIKit
import CoreLocation

protocol Locatable {
    func didLocateSuccessfully(location: String)
}



class TutorialViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        findMyLocaiton()
    }
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: UIScreen.main.bounds.height * 0.05, width: UIScreen.main.bounds.width, height: 150)
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.text = "Enter a location for, \naccurate times"
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
        textField.borderStyle = .roundedRect
        textField.alpha = 0.90
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.placeholder = "Enter a city or state"
        textField.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 50, height: 53.16)
        return textField
    }()
    
    let findMeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Find Me", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.alpha = 0.5
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 46)
        return button
    }()
}

// MARK: - Methods
extension TutorialViewController: UITextFieldDelegate{
    
    func setupViews() {
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0.6189187169, blue: 0.9825027585, alpha: 1)
        self.view.addSubview(welcomeLabel)
        completeButton.frame.origin.y = self.view.frame.height - 50
        self.view.addSubview(completeButton)
        locationTextField.center = self.view.center
        locationTextField.delegate = self
        self.view.addSubview(locationTextField)
        findMeButton.center.x = self.view.center.x
        findMeButton.center.y = locationTextField.center.y + 100
        self.view.addSubview(findMeButton)
    }
    
    func findMyLocaiton() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    
}

// MARK: - TextField Delegate Methods
extension TutorialViewController {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
}


// MARK: - Location Manager Delegate Methods
extension TutorialViewController {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!) { (placeMarks, error) in
            if let error = error {
                print("reverse geocoder fialed with error: \(error.localizedDescription)")
            }
            if let placeMarks = placeMarks {
                if placeMarks.count > 0 {
                    let pm = placeMarks[0] as CLPlacemark
                    self.getLocaitonInfo(placeMark: pm)
                } else {
                    print("problem with the data recieved")
                }
            }
        }
    }
    
    func getLocaitonInfo(placeMark: CLPlacemark?) {
        if let placeMark = placeMark {
            locationManager.stopUpdatingLocation()
            if let locality = placeMark.locality {
                print(locality)
            }
            
            if let adminArea = placeMark.administrativeArea {
                print(adminArea)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while updating location \(error.localizedDescription)")
    }
}












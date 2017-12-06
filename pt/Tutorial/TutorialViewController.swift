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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        locationTextField.delegate = self
        locationTextField.layer.cornerRadius = 25
        locationTextField.clipsToBounds = true
        findMeButton.layer.cornerRadius = 25
        
        
        
    }
    
    let locationManager = CLLocationManager()

    
    let completeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Complete", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(#colorLiteral(red: 0, green: 0.6189187169, blue: 0.9825027585, alpha: 1), for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    
    var delegate: Locatable?
    
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var findMeButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    
    @IBAction func locateMeButtonTapped(_ sender: Any) {
        findMyLocaiton()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        if let location = locationTextField.text, !location.isEmpty {
            delegate?.didLocateSuccessfully(location: location)
        } else {
            // something else
        }
    }
    
    
}

// MARK: - Methods
extension TutorialViewController {
    
    func findMyLocaiton() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    

}

// MARK: - TextField Delegate Methods
extension TutorialViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}


// MARK: - Location Manager Delegate Methods
extension TutorialViewController {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
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
            if let adminArea = placeMark.administrativeArea {
                print(adminArea)
                delegate?.didLocateSuccessfully(location: adminArea)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while updating location \(error.localizedDescription)")
    }
}












//
//  MainViewController.swift
//  pt
//
//  Created by Ilias Basha on 11/16/17.
//  Copyright © 2017 Sohail. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, CLLocationManagerDelegate, Locatable {
    
    private let cellID = "detailCell"
    let locationManager = CLLocationManager()

    
    var isLocated: Bool = false {
        didSet {
            
        }
    }
    
    var location: String? {
        didSet {
            
        }
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumLineSpacing = 1
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        let cv = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        return cv
    }()
    
    let backgroundView: UIImageView = {
       let imageView = UIImageView()
        imageView.frame = UIScreen.main.bounds
        imageView.image = #imageLiteral(resourceName: "background")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DetailsCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        self.view.addSubview(backgroundView)
        self.view.addSubview(collectionView)
   
        
        PrayerController.sharedInstance.fetch(location: "NewYork") { (success) in
            if success {
                PrayerController.sharedInstance.prayers.sort(by: {$0.order < $1.order})
    
                DispatchQueue.main.async {
                    guard let cell = self.collectionView.visibleCells[0] as? DetailsCollectionViewCell else { return }
                    cell.timeTableCollectionView.reloadData()
                    self.nextPrayer()
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let location = location {
            
            print("location is not nil")
        } else {
            self.performSegue(withIdentifier: "showLocator", sender: self)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? DetailsCollectionViewCell
        return cell ?? UICollectionViewCell()
    }
    
    func nextPrayer() {
        let prayers = PrayerController.sharedInstance.prayers
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let timeArray = prayers.map{ Calendar.current.dateComponents([.hour, .minute],
                                                                     from: formatter.date(from: $0.time.uppercased())!) }
        
        let upcomingTimes = timeArray.map{ Calendar.current.nextDate(after: Date(),
                                                                     matching: $0,
                                                                     matchingPolicy: .nextTime)!}
        
        guard let nextTime = upcomingTimes.sorted().first else {
            return
        }
        let formatterString = formatter.string(from: nextTime)
        let prayer = prayers.filter{$0.time.uppercased() == formatterString}
        print(prayer.first!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLocator" {
            if let destinationVC = segue.destination as? TutorialViewController {
                destinationVC.delegate = self
            }
        }
    }
    
    func didLocateSuccessfully(location: String) {
        self.location = location
    }
    
}



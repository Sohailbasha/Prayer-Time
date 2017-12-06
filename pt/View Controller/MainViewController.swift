//
//  MainViewController.swift
//  pt
//
//  Created by Ilias Basha on 11/16/17.
//  Copyright © 2017 Sohail. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, Locatable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DetailsCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        self.view.addSubview(backgroundView)
        self.view.addSubview(collectionView)
        
        locationButton.frame = CGRect(x: (self.view.center.x - 50), y: 20, width: 100, height: 25) // center is subtracted by width/2

        if let locationName = locationName {
            self.fetchPrayers(from: locationName)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if locationName == nil {
            self.performSegue(withIdentifier: "showLocator", sender: self)
        }
    }
    
    private let cellID = "detailCell"

    var locationName: String? {
        didSet {
            if let locationName = self.locationName {
                fetchPrayers(from: locationName)
            }
        }
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumLineSpacing = 1
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 20)
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
    
    
    let locationButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("", for: .normal)
        button.setImage(#imageLiteral(resourceName: "map-pin"), for: .normal)
        button.imageView?.tintColor = UIColor.white
        let spacing: CGFloat = 10
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0)
        return button
    }()
    
    
    func fetchPrayers(from location: String) {
//        let requestLocation = location.trimmingCharacters(in: .whitespaces)
        PrayerController.sharedInstance.fetch(location: location) { (success) in
            if(success) {
                PrayerController.sharedInstance.prayers.sort(by: {$0.order < $1.order})
                DispatchQueue.main.async {
                    guard let cell = self.collectionView.visibleCells[0] as? DetailsCollectionViewCell else { return }
                    cell.timeTableCollectionView.reloadData()
                    cell.locationButton.setTitle(location, for: .normal)
                    
                }
            } else  {
                PrayerController.sharedInstance.fetch(location: "NewYork", completion: { (_) in
                    PrayerController.sharedInstance.prayers.sort(by: {$0.order < $1.order})
                })
            }
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
        self.locationName = location
        
        dismiss(animated: true, completion: nil)
    }
    
}



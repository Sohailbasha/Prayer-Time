//
//  MainViewController.swift
//  pt
//
//  Created by Ilias Basha on 11/16/17.
//  Copyright © 2017 Sohail. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    private let cellID = "detailCell"
    
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
        LocationManager.sharedInstance.start()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DetailsCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        self.view.addSubview(backgroundView)
        self.view.addSubview(collectionView)
        LocationManager.sharedInstance.locationString { (string) in
            print("fetched from reverseGeoFencing")
        }
        
        PrayerController.sharedInstance.fetch(location: "NewYork") { (success) in
            if success {
                PrayerController.sharedInstance.prayers.sort(by: {$0.order < $1.order})
                print("step 2")
                DispatchQueue.main.async {
                    guard let cell = self.collectionView.visibleCells[0] as? DetailsCollectionViewCell else { return }
                    cell.timeTableCollectionView.reloadData()
                }
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
}




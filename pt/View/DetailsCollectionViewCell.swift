//
//  DetailsCollectionViewCell.swift
//  pt
//
//  Created by Ilias Basha on 11/16/17.
//  Copyright © 2017 Sohail. All rights reserved.
//

import UIKit

class DetailsCollectionViewCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let cellID = "playerCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        upcomingLabel.frame = CGRect(x: 8, y: frame.size.height * 0.10, width: frame.size.width - 10, height: 45)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let upcomingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "Upcoming Prayer"
        return label
    }()
    
    let timeTableCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let frame = CGRect(x: 0, y: UIScreen.main.bounds.height *  0.25, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 0.5)
        let cv = UICollectionView(frame: frame, collectionViewLayout: layout)
        cv.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3454088185)
        return cv
    }()
    
    func setupViews() {
        self.backgroundColor = .white
        timeTableCollectionView.dataSource = self
        timeTableCollectionView.delegate = self
        timeTableCollectionView.register(PrayerCell.self, forCellWithReuseIdentifier: cellID)
        addSubview(timeTableCollectionView)
        addSubview(upcomingLabel)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PrayerController.sharedInstance.prayers.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? PrayerCell
        let prayer = PrayerController.sharedInstance.prayers[indexPath.row]
        cell?.prayer = prayer
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let leftAndRightPaddings: CGFloat = 7
        let numberOfItemsPerRow: CGFloat = 5.0
        let width = (timeTableCollectionView.frame.width - (leftAndRightPaddings * (numberOfItemsPerRow + 1))) / numberOfItemsPerRow
        let height = timeTableCollectionView.frame.height
        let size = CGSize(width: width, height: height)
        
        return size
    }
}

class PrayerCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        prayerNameLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height * 0.5)
        timeLabel.frame = CGRect(x: 0, y: prayerNameLabel.frame.height, width: frame.width, height: frame.height * 0.5)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let prayerNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = "Prayer"
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = "Time"
        return label
    }()
    
    var prayer: Prayer? {
        didSet {
            if let prayer = self.prayer {
                self.prayerNameLabel.text = prayer.name.capitalized
                self.timeLabel.text = prayer.time
            }
        }
    }
    
    func setupViews() {
        addSubview(prayerNameLabel)
        addSubview(timeLabel)
        backgroundColor = UIColor.blue
    }
}














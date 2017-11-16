//
//  DetailsCollectionViewCell.swift
//  pt
//
//  Created by Ilias Basha on 11/16/17.
//  Copyright © 2017 Sohail. All rights reserved.
//

import UIKit

class DetailsCollectionViewCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let timeTableCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let frame = CGRect(x: 0, y: UIScreen.main.bounds.height *  0.25, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 0.5)
        let cv = UICollectionView(frame: frame, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    func setupViews() {
        self.backgroundColor = .black
        timeTableCollectionView.dataSource = self
        timeTableCollectionView.delegate = self
        addSubview(timeTableCollectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: <#T##String#>, for: <#T##IndexPath#>)
    }
}
















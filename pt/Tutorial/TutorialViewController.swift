//
//  TutorialViewController.swift
//  pt
//
//  Created by Ilias Basha on 11/21/17.
//  Copyright © 2017 Sohail. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0.6189187169, blue: 0.9825027585, alpha: 1)
        self.view.addSubview(welcomeLabel)
    }

    let welcomeLabel: UILabel = {
       let label = UILabel()
        label.frame = CGRect(x: 0, y: UIScreen.main.bounds.height * 0.10, width: UIScreen.main.bounds.width, height: 150)
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.text = "Welcome \n Thank you for downloading"
        return label
    }()
    
    
 
}















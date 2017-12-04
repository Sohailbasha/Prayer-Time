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
        completeButton.frame.origin.y = self.view.frame.height - 50
        self.view.addSubview(completeButton)
    }

    let welcomeLabel: UILabel = {
       let label = UILabel()
        label.frame = CGRect(x: 0, y: UIScreen.main.bounds.height * 0.10, width: UIScreen.main.bounds.width, height: 150)
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













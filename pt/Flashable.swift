//
//  Flashable.swift
//  pt
//
//  Created by Ilias Basha on 12/6/17.
//  Copyright © 2017 Sohail. All rights reserved.
//

import UIKit

protocol Flashable {}

extension Flashable where Self: UIView {
    func flash() {
        jitter()
        UIView.animate(withDuration: 0.05, animations: {
            self.alpha = 0.75
        }) { (_) in
            UIView.animate(withDuration: 0.05, animations: {
                self.alpha = 1.0
            })
        }
    }
    
    func jitter() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint.init(x: self.center.x - 5.0, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint.init(x: self.center.x + 5.0, y: self.center.y))
        layer.add(animation, forKey: "position")
    }
}

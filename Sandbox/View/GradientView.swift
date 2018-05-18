//
//  GradientView.swift
//  Sandbox
//
//  Created by Sebastian on 5/14/18.
//  Copyright © 2018 Sebastian. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    let gradient = CAGradientLayer()
    
    func setUpGradientView() {
        gradient.frame = self.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.init(white: 1.0, alpha: 0.0).cgColor]
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 0, y: 1)
        // First color stops at 80%, second color at 100%
        gradient.locations = [0.8, 1.0]
        self.layer.addSublayer(gradient)
    }
    
    override func awakeFromNib() {
        setUpGradientView()
    }
    
}

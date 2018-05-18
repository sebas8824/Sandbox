//
//  RoundImageView.swift
//  Sandbox
//
//  Created by Sebastian on 5/14/18.
//  Copyright © 2018 Sebastian. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {

    override func awakeFromNib() {
        setUpView()
    }
    
    func setUpView() {
        self.layer.cornerRadius = (self.frame.width / 2)
        self.clipsToBounds = true
    }
    
}

//
//  RoundedShadowButton.swift
//  Sandbox
//
//  Created by Sebastian on 5/14/18.
//  Copyright © 2018 Sebastian. All rights reserved.
//

import UIKit

class RoundedShadowButton: UIButton {

    var originalSize: CGRect?
    
    override func awakeFromNib() {
        setUpView()
    }
    
    func setUpView() {
        originalSize = self.frame
        self.layer.cornerRadius = 5.0
        self.layer.shadowRadius = 10.0
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize.zero
    }

    func animateButton(shouldLoad: Bool, withMessage message: String?) {
        let spinner = UIActivityIndicatorView()
        spinner.activityIndicatorViewStyle = .whiteLarge
        spinner.color = UIColor.darkGray
        spinner.alpha = 0.0
        spinner.hidesWhenStopped = true
        spinner.tag = 88
        
        if shouldLoad {
            self.addSubview(spinner)
            self.setTitle("", for: .normal)
            UIView.animate(withDuration: 0.2, animations: {
                self.layer.cornerRadius = (self.frame.height / 2)
                // Making the button squared before making it rounded
                // Move the left side of the button to the middle of the screen and center it for x
                // The y point will be the same after using self.frame.origin.y
                self.frame = CGRect(
                    x: (self.frame.midX - (self.frame.height / 2)),
                    y: self.frame.origin.y,
                    width: self.frame.height,
                    height: self.frame.height
                )
            }, completion: { (finished) in
                if finished == true {
                    spinner.startAnimating()
                    spinner.center = CGPoint(x: self.frame.width / 2, y: (self.frame.width / 2) + 1)
                    spinner.fadeTo(alphaValue: 1.0, withDuration: 0.2)
                }
            })
            self.isUserInteractionEnabled = false
        } else {
            self.isUserInteractionEnabled = true
            
            for subview in self.subviews {
                if subview.tag == 88 {
                    subview.removeFromSuperview()
                }
            }
            
            UIView.animate(withDuration: 0.2) {
                self.layer.cornerRadius = 5.0
                self.frame = self.originalSize!
                self.setTitle(message, for: .normal)
            }
        }
    }
}

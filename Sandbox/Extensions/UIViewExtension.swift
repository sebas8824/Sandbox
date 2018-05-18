//
//  UIViewExtension.swift
//  Sandbox
//
//  Created by Sebastian on 5/14/18.
//  Copyright © 2018 Sebastian. All rights reserved.
//

import UIKit

extension UIView {
    func fadeTo(alphaValue: CGFloat, withDuration duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.alpha = alphaValue
        }        
    }
}

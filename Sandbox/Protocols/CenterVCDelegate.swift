//
//  CenterVCDelegate.swift
//  Sandbox
//
//  Created by Sebastian on 5/14/18.
//  Copyright © 2018 Sebastian. All rights reserved.
//

import UIKit

protocol CenterVCDelegate {
    func toggleLeftPanel()
    func addLeftPanelViewController()
    func animateLeftPanel(shouldExpand: Bool)
}

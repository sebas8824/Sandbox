//
//  HomeVC
//  Sandbox
//
//  Created by Sebastian on 5/13/18.
//  Copyright © 2018 Sebastian. All rights reserved.
//

import UIKit
import MapKit

class HomeVC: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var actionButton: RoundedShadowButton!
    
    var delegate: CenterVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapView.delegate = self
    }

    // MARK: Action buttons
    
    @IBAction func actionButton(_ sender: Any) {
        actionButton.animateButton(shouldLoad: true, withMessage: nil)
    }
    @IBAction func menuButton(_ sender: Any) {
        delegate?.toggleLeftPanel()
    }

}


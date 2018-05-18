//
//  ContainerVC.swift
//  Sandbox
//
//  Created by Sebastian on 5/14/18.
//  Copyright © 2018 Sebastian. All rights reserved.
//

import UIKit
import QuartzCore

// To know whether or not the side menu is extended
enum SlideOutState {
    case collapsed
    case leftPanelExtended
}

enum ShowWhichVC {
    case homeVC
}

// Default VC
var showVC: ShowWhichVC = .homeVC

// This containerVC will contain the leftSidePanelVC, hence the private extension
class ContainerVC: UIViewController {

    // variable to instatiate homeVC
    var homeVC: HomeVC!
    var leftVC: LeftSidePanelVC!
    var centerController: UIViewController!
    var currentState: SlideOutState = .collapsed {
        didSet {
            let shouldShowShadow = (currentState != .collapsed)
            shouldShowShadowForCenterViewController(status: shouldShowShadow)
        }
    }
    var isHidden = false
    
    let centerPanelExpandedOffset: CGFloat = 160
    var tap: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCenter(screen: showVC)
    }

    // Initializes VC on the center and clears everything before adding a new VC
    func initCenter(screen: ShowWhichVC) {
        var presentingController: UIViewController
        showVC = screen
        if homeVC == nil {
            homeVC = UIStoryboard.homeVC()
            homeVC.delegate = self
        }
        
        presentingController = homeVC
        if let con = centerController {
            con.view.removeFromSuperview()
            con.removeFromParentViewController()
        }
        
        centerController = presentingController
        view.addSubview(centerController.view)
        addChildViewController(centerController)
        centerController.didMove(toParentViewController: self)
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return isHidden
    }
}

extension ContainerVC: CenterVCDelegate {
    
    // MARK: Conforming the protocol
    // Check if its expanded
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .leftPanelExtended)
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func addLeftPanelViewController() {
        if leftVC == nil {
            leftVC = UIStoryboard.leftViewController()
            addChildSidePanelViewController(leftVC)
            
        }
    }
    
    @objc func animateLeftPanel(shouldExpand: Bool) {
        if shouldExpand {
            isHidden = !isHidden
            animateStatusBar()
            setUpWhiteCoverView()
            animateCenterPanelXPosition(targetPosition: centerController.view.frame.width - centerPanelExpandedOffset)
            currentState = .leftPanelExtended
        } else {
            isHidden = !isHidden
            animateStatusBar()
            hideWhiteCoverView()
            animateCenterPanelXPosition(targetPosition: 0) { (finished) in
                if finished == true {
                    self.currentState = .collapsed
                    self.leftVC = nil
                }
            }
        }
    }
    
    // MARK: Functions
    
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.centerController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    
    // Inserting a subview at zero, adds psvc as a child and move it to containerVC
    func addChildSidePanelViewController(_ sidePanelController: LeftSidePanelVC) {
        view.insertSubview(sidePanelController.view, at: 0)
        addChildViewController(sidePanelController)
        sidePanelController.didMove(toParentViewController: self)
    }
    
    func animateStatusBar() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        })
    }
    
    func setUpWhiteCoverView() {
        // A view that covers the entire VC
        let whiteCoverView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        whiteCoverView.alpha = 0.0
        whiteCoverView.backgroundColor = UIColor.white
        whiteCoverView.tag = 89
        
        self.centerController.view.addSubview(whiteCoverView)
        whiteCoverView.fadeTo(alphaValue: 0.75, withDuration: 0.2)
        
        tap = UITapGestureRecognizer(target: self, action:#selector(animateLeftPanel(shouldExpand:)))
        tap.numberOfTapsRequired = 1
        self.centerController.view.addGestureRecognizer(tap)
    }
    
    func shouldShowShadowForCenterViewController(status: Bool) {
        if status == true {
            centerController.view.layer.shadowOpacity = 0.6
        } else {
            centerController.view.layer.shadowOpacity = 0.0
        }
    }
    
    func hideWhiteCoverView() {
        centerController.view.removeGestureRecognizer(tap)
        for subview in self.centerController.view.subviews {
            if subview.tag == 89 {
                UIView.animate(withDuration: 0.2, animations: {
                    subview.alpha = 0.0
                }) { (finished) in
                    subview.removeFromSuperview()
                }
            }
        }
    }
}

private extension UIStoryboard {
    class func mainStoryBoard() -> UIStoryboard {
        // We can access the story board
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    class func leftViewController() -> LeftSidePanelVC? {
        return mainStoryBoard().instantiateViewController(withIdentifier: "LeftSidePanelVC") as? LeftSidePanelVC
    }
    
    class func homeVC() -> HomeVC? {
        return mainStoryBoard().instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
    }
}

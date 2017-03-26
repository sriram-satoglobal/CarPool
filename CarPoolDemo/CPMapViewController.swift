//
//  CPMapViewController.swift
//  CarPoolDemo
//
//  Created by Sriram Reddy on 3/25/17.
//  Copyright © 2017 SGS Inc. All rights reserved.
//

import UIKit

class CPMapViewController: CPBaseViewController {

    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpRevealingMenuPattern()
    }
    
    func setUpRevealingMenuPattern() {
        if revealViewController() != nil {
            menuBarButton.target = self.revealViewController()
            menuBarButton.action = #selector((SWRevealViewController.revealToggle) as (SWRevealViewController) -> (Void) -> Void) // Swift 3 fix
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
}

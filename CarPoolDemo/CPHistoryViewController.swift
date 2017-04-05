//
//  CPHistoryViewController.swift
//  CarPoolDemo
//
//  Created by Tejaswi Yarlagadda on 3/25/17.
//  Copyright © 2017 Demo Inc. All rights reserved.
//

import UIKit

class CPHistoryViewController: CPBaseViewController {

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

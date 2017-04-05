//
//  CPDemoViewController.swift
//  CarPoolDemo
//
//  Created by Tejaswi Yarlagadda on 3/23/17.
//  Copyright © 2017 Demo Inc. All rights reserved.
//

import UIKit

class CPDemoViewController: CPBaseViewController {

    @IBOutlet weak var pageContainerView: UIView!
    
    //MARK:- View Controller Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        _ = navigationController?.popViewController(animated: true)
    }
}

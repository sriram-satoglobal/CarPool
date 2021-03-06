//
//  CPRideOptionsViewController.swift
//  CarPoolDemo
//
//  Created by Tejaswi Yarlagadda on 3/31/17.
//  Copyright © 2017 Demo Inc. All rights reserved.
//

import UIKit
import MapKit
class CPSelectRideOptionViewController: CPBaseViewController {
    var selectedRoute: MKRoute?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showReceipt" {
            let summaryVC = segue.destination as! CPSummaryViewController
            summaryVC.selectedRoute = selectedRoute
        }
    }
}

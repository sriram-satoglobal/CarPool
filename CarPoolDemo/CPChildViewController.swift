//
//  CPChildViewController.swift
//  CarPoolDemo
//
//  Created by Sriram Reddy on 3/23/17.
//  Copyright © 2017 SGS Inc. All rights reserved.
//

import UIKit

class CPChildViewController: CPBaseViewController {

    var index: Int = 0
    var demoEntity: CPDemoEntity? 
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var demoImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!

    //MARK:- View Controller Life Cycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    func reloadData() {
        titleLabel.text = demoEntity?.title
        demoImageView.image = (demoEntity?.image)!
        descriptionLabel.text = demoEntity?.description
    }
}

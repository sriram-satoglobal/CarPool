//
//  CPRideOptionVIewController.swift
//  CarPoolDemo
//
//  Created by Tejaswi Yarlagadda on 3/31/17.
//  Copyright © 2017 Demo Inc. All rights reserved.
//

import UIKit

class CPRideOptionVIewController: CPBaseViewController {

    var index: Int = 0
    var demoEntity: CPRideOptionEntity?
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
        var activeStars = demoEntity?.activeStars
        for tag in 10...14 {
            if let imageView = view.viewWithTag(tag) as? UIImageView {
                imageView.image =  activeStars! > 0 ? #imageLiteral(resourceName: "star_enable") : #imageLiteral(resourceName: "star_disable")
                activeStars! -= 1
            }
        }
    }

}

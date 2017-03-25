//
//  CPLoginViewController.swift
//  CarPoolDemo
//
//  Created by Sriram Reddy on 3/23/17.
//  Copyright © 2017 SGS Inc. All rights reserved.
//

import UIKit

class CPLoginViewController: CPBaseViewController {

    //MARK:- View Controller Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {
        
    }
}

extension CPLoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//
//  CPSignUpViewController.swift
//  CarPoolDemo
//
//  Created by Sriram Reddy on 3/23/17.
//  Copyright © 2017 SGS Inc. All rights reserved.
//

import UIKit

class CPSignUpViewController: CPBaseViewController {

    var _currentTF: UITextField?
    
    //MARK:- View Controller Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        _currentTF?.resignFirstResponder()
    }
    
    @IBAction func goBackToLogin() {
        performSegue(withIdentifier: "unwindSegueToLogin", sender: self)
    }
}

extension CPSignUpViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        _currentTF = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

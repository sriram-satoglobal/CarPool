//
//  CPBaseViewController.swift
//  CarPoolDemo
//
//  Created by Sriram Reddy on 3/23/17.
//  Copyright © 2017 SGS Inc. All rights reserved.
//

import UIKit

class CPBaseViewController: UIViewController {
    
    //MARK:- View Controller Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ notification: Notification){
        let keyInfo = notification.userInfo
        var keyboardFrame = keyInfo?[UIKeyboardFrameEndUserInfoKey] as! CGRect
        keyboardFrame = view.convert(keyboardFrame, from: nil)
        _ = keyboardFrame.intersection(view.bounds)
        _ = keyInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        
    }
    
    func keyboardWillHide(_ notification: Notification){
        let keyInfo = notification.userInfo
        _ = keyInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        
    }
    
}

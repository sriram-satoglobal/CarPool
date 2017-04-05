//
//  CPTextField.swift
//  CarPoolDemo
//
//  Created by Tejaswi Yarlagadda on 3/27/17.
//  Copyright © 2017 Demo Inc. All rights reserved.
//

import UIKit

@IBDesignable
class CPTextField: UITextField {
    @IBInspectable var borderColor: UIColor = .lightGray
    @IBInspectable var borderWidth: CGFloat = 2.0
    @IBInspectable var shadowColor: UIColor = .red
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 2.0, height: 2.0)
    @IBInspectable var shadowRadius: CGFloat = 1.0
    @IBInspectable var shadowOpacity: Float = 1.0
    @IBInspectable var cornerRadius: CGFloat = 1.0
    @IBInspectable var textPadding: CGFloat = 10.0
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.cornerRadius = cornerRadius
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var newRect = bounds
        newRect.origin.x += textPadding
        newRect.size.width -= textPadding
        return newRect
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var newRect = bounds
        newRect.origin.x += textPadding
        newRect.size.width -= textPadding
        return newRect
    }
}

//
//  CPExtensions.swift
//  CarPoolDemo
//
//  Created by Sriram Reddy on 3/24/17.
//  Copyright © 2017 SGS Inc. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    var height: CGFloat {
        return frame.size.height
    }
    
    var width: CGFloat {
        return frame.size.height
    }
    
    var x: CGFloat {
        return frame.origin.x
    }
    
    var y: CGFloat {
        return frame.origin.y
    }
    
    func printFrame() {
        print(frame)
    }
}

//
//  CPExtensions.swift
//  CarPoolDemo
//
//  Created by Tejaswi Yarlagadda on 3/24/17.
//  Copyright © 2017 Demo Inc. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
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

extension NotificationCenter {
    ///This will remove any observers with block invocation. Usage: let token = addObserver(...block call). pass the token to remove observer
    func removeObserver(blockToken token:Any?, notificationName name: Notification.Name, object: Any? = nil) {
        if token != nil {
            removeObserver(token!, name: name, object: object)
        }
    }
}

@available(iOS 10.0, *)
extension UIViewController {
    //This will show single interaction button alert on any View Controller.
    func showAlert(withTitle title: String = "", message: String, confirmationTitle: String = "OK", completionHandler: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: confirmationTitle, style: .cancel, handler: { (action) in
            completionHandler?()
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    //Shows alert with default title as "Error!"
    func showError(withMessage message: String, confirmationTitle: String = "OK", completionHandler: (() -> Void)? = nil) {
        showAlert(withTitle: "Error!", message: message, confirmationTitle: confirmationTitle, completionHandler: completionHandler)
    }
    
    
    func showError(_ anyError: Error, confirmationTitle: String = "OK", completionHandler: (() -> Void)? = nil) {
        showError(withMessage: anyError.localizedDescription, confirmationTitle: confirmationTitle, completionHandler: completionHandler)
    }
    
    func askForLocationAccessIfNeeded(completionHandler:(Bool, CLAuthorizationStatus, NSError?) -> Void) {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            completionHandler(true, status, nil)
            break
        case .denied, .restricted:
            completionHandler(false, status, NSError.error(withMessage: "This application needs location access to continue. Please change the location access from 'Settings'"))
            break
        default:
            completionHandler(false, status, nil)
            break
        }
    }
}

extension NSError {
    private static var kErrorDomain: String {
        return "com.sato.errorDomain"
    }
    static func error(withMessage message: String) -> NSError {
        return NSError(domain: kErrorDomain, code: 111, userInfo: [NSLocalizedDescriptionKey : message])
    }
    
    
    /// Creates Error
    ///
    /// - Parameters:
    ///   - description: NSLocalizedDescriptionKey
    ///   - recoverKey: NSLocalizedRecoverySuggestionErrorKey
    /// - Returns: NSError
    static func error(withDescription description: String, recoverKey: String = "") -> NSError {
        return NSError(domain: kErrorDomain, code: 111, userInfo: [NSLocalizedDescriptionKey : description, NSLocalizedRecoverySuggestionErrorKey : recoverKey])
    }
}


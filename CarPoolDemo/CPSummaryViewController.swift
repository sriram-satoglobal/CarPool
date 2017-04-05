//
//  CPSelectRideViewController.swift
//  CarPoolDemo
//
//  Created by Tejaswi Yarlagadda on 3/27/17.
//  Copyright © 2017 Demo Inc. All rights reserved.
//

import UIKit
import MapKit
class CPSummaryViewController: UITableViewController {

    @IBOutlet weak var personCountLabel: UILabel!
    
    var selectedRoute: MKRoute?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getStartTime() -> String {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let minZeroStr = minutes < 10 ? "0" : ""
        let hourZeroStr = hour < 10 ? "0" : ""
        return "\(hourZeroStr)\(hour + 1):\(minZeroStr)\(minutes) "
    }
    
    func calculatePrice() -> Double {
        let perMileCharge = 0.50
        var charge: Double = 0.0
        if let count = Int(personCountLabel.text!) {
            charge = Double(count) * Double((selectedRoute?.distance ?? 0.0)! * 0.000621371) * perMileCharge
        }
        charge *= 1.02
        return charge
    }
    
    @IBAction func increasePersonCount() {
        if let count = Int(personCountLabel.text!) {
            personCountLabel.text = "\(count+1)"
            tableView.reloadData()
        }
    }
    
    @IBAction func decreasePersonCount() {
        if let count = Int(personCountLabel.text!), count > 1 {
            personCountLabel.text = "\(count-1)"
            tableView.reloadData()
        }
    }
    
    @IBAction func showSuccess() {
        showAlert(withTitle: "Success!", message: "Your ride has been successfully scheduled. Thanks for choosing Pay-A-Way") { 
            self.navigationController?.popToRootViewController(animated: true)
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 4 {
            return 100
        }
        return 70.0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell\(indexPath.row)Id", for: indexPath)
        cell.selectionStyle = .none
        switch indexPath.row {
        case 1:
            let currentText = String(format: "%0.2f  miles ", (selectedRoute?.distance ??  0.0)! * 0.000621371)
            cell.detailTextLabel?.attributedText = attributedDisplayText(currentText)
            break
        case 2:
            let currentText = String(format: "%0.2f min ", (selectedRoute?.expectedTravelTime ?? 0.0)! / 60.0)
            cell.detailTextLabel?.attributedText = attributedDisplayText(currentText)
            break
        case 3:
            cell.detailTextLabel?.attributedText = attributedDisplayText(getStartTime())
            break
        case 4:
            cell.detailTextLabel?.text = String(format: "%0.2f USD ", calculatePrice())
            break
        default: break
            
        }
        
        return cell
    }
    
    
    
    func attributedDisplayText(_ text: String) -> NSAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 2.0
        
        return NSAttributedString(string: text, attributes: [NSForegroundColorAttributeName: UIColor.darkGray, NSUnderlineStyleAttributeName: NSNumber(value: 0.5), NSUnderlineColorAttributeName: UIColor.lightGray, NSFontAttributeName: UIFont.systemFont(ofSize: 16), NSParagraphStyleAttributeName: paragraph])
    }
}

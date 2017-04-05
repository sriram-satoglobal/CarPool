//
//  CPLeftMenuViewController.swift
//  CarPoolDemo
//
//  Created by Tejaswi Yarlagadda on 3/25/17.
//  Copyright © 2017 Demo Inc. All rights reserved.
//

import UIKit

class CPLeftMenuViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "mapCell", for: indexPath)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "signOutCell", for: indexPath)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "show_map", sender: self)
            break
        case 1:
            performSegue(withIdentifier: "show_history", sender: self)
            break
        default:
            _ = navigationController?.popToRootViewController(animated: true)
        }
    }
}

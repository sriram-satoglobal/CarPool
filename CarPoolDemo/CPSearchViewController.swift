//
//  CPSearchViewController.swift
//  CarPoolDemo
//
//  Created by Sriram Reddy on 3/27/17.
//  Copyright © 2017 SGS Inc. All rights reserved.
//

import UIKit
import MapKit
protocol CPSearchControllerDelegate: class {
    func didBeginInteracting()
    func didEndInteracting()
    func didBeginShowingResults(_ resultCount: Int)
    func didSelectResult(withSearchCompletion: MKLocalSearchCompletion, _ coordinate: CLLocationCoordinate2D)
}

class CPSearchViewController: UIViewController {

    weak var delegate: CPSearchControllerDelegate?
    
    let cellId = "CPLocationSearchCellIdentifier"
    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var searchTF: CPTextField!
    var locationsArray: [MKLocalSearchCompletion] = []
    let searchCompleter = MKLocalSearchCompleter()
    var textChangeNotificationToken: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchCompleter.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    func addObserver() {
        textChangeNotificationToken = NotificationCenter.default.addObserver(forName: .UITextFieldTextDidChange, object: nil, queue: OperationQueue.main) { (notification) in
            self.searchCompleter.queryFragment = self.searchTF.text!
        }
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(blockToken: textChangeNotificationToken, notificationName: .UITextFieldTextDidChange)
    }
}




//MARK :- UITableViewDataSource
extension CPSearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CPLocationSearchCell
        let location = locationsArray[indexPath.row]
        cell.textLabel?.text = location.title
        cell.detailTextLabel?.text = location.subtitle
        return cell
    }
}


extension CPSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let locationCompletion = locationsArray[indexPath.row]
        removeObserver()
        searchTF.text = locationCompletion.title
        searchTF.resignFirstResponder()
        
        let searchRequest = MKLocalSearchRequest(completion: locationCompletion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            if error == nil {
                let coordinate = response?.mapItems[0].placemark.coordinate
                self.delegate?.didSelectResult(withSearchCompletion: self.locationsArray[indexPath.row], coordinate!)
            } else {
              print(error!)
            }
        }
    }
}


extension CPSearchViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        locationsArray = completer.results
        delegate?.didBeginShowingResults(locationsArray.count)
        resultsTableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error)
    }
}

extension CPSearchViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        addObserver()
        delegate?.didBeginInteracting()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        removeObserver()
        delegate?.didEndInteracting()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//
//  CPMapViewController.swift
//  CarPoolDemo
//
//  Created by Sriram Reddy on 3/25/17.
//  Copyright © 2017 SGS Inc. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class CPMapViewController: CPBaseViewController {

    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    
    var nextBarButton: UIBarButtonItem? = nil
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var didBecomeActiveToken: NSObjectProtocol?
    var serachViewController: CPSearchViewController?
    var selectedRoute: MKRoute?
    
    var currentOverlay: MKOverlay?
    var currentViewingAnnotations: [MKAnnotation] = []
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var topSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    
    var currentPlacemark: MKPlacemark?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpRevealingMenuPattern()
        locationManager.delegate = self
        nextBarButton  = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(goNext))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleResultSetVisibility(makeVisible: false, isThisResultsVew: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func requestAuthorizationIfNeeded() {
        askForLocationAccessIfNeeded { (granted, status, error) in
            print(status)
            if !granted {
                if error != nil {
                    self.showError(error!, completionHandler: {
                        UIApplication.shared.open(URL(string:UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
                    })
                }
                else {
                    self.locationManager.requestWhenInUseAuthorization()
                }
            }
            else {
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startUpdatingLocation()
                mapView.showsUserLocation = true
            }
        }
    }
    
    func setUpRevealingMenuPattern() {
        if revealViewController() != nil {
            menuBarButton.target = self.revealViewController()
            menuBarButton.action = #selector((SWRevealViewController.revealToggle) as (SWRevealViewController) -> (Void) -> Void) // Swift 3 fix
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    func handleResultSetVisibility(makeVisible: Bool, isThisResultsVew: Bool) {
        self.leftSpaceConstraint.constant = makeVisible ? 20.0 : 30.0
        self.heightConstraint.constant = isThisResultsVew ? 300 : 40
        self.topSpaceConstraint.constant = makeVisible ? 0 : 50
        navigationController?.setNavigationBarHidden(makeVisible, animated: true)
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "MapEmbedSegueToSearchIdentifier") {
            let searchVC = segue.destination  as! CPSearchViewController
            self.serachViewController = searchVC
            self.serachViewController?.delegate = self
        }
        else if (segue.identifier == "selectRideType") {
            let selectRideVC = segue.destination  as! CPSelectRideOptionViewController
            selectRideVC.selectedRoute = selectedRoute
        }
    }
    
    
    func drawRoute(sourcePlacemark: MKPlacemark, destinationPlacemark: MKPlacemark) {
        
        if currentOverlay != nil {
            mapView.remove(currentOverlay!)
            mapView.removeAnnotations(currentViewingAnnotations)
        }
        
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = sourcePlacemark.title
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = destinationPlacemark.title
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        currentViewingAnnotations = [sourceAnnotation, destinationAnnotation]
        
        self.mapView.showAnnotations(currentViewingAnnotations, animated: true )
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                return
            }
            
            let route = response.routes[0]
            self.selectedRoute = route
            self.mapView.add((route.polyline), level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
            self.navigationItem.rightBarButtonItem = self.nextBarButton
        }
    }
    
    func goNext() {
        performSegue(withIdentifier: "selectRideType", sender: self)
    }
}


extension CPMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
        requestAuthorizationIfNeeded()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.first
        currentPlacemark = MKPlacemark(coordinate: (currentLocation?.coordinate)!)
    }
}

extension CPMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .red
        renderer.lineWidth = 5.0
        currentOverlay = overlay
        return renderer
    }
}


extension CPMapViewController: CPSearchControllerDelegate {
    
    func didBeginInteracting() {
        handleResultSetVisibility(makeVisible: true, isThisResultsVew: false)
    }
    
    func didBeginShowingResults(_ count: Int) {
        handleResultSetVisibility(makeVisible: true, isThisResultsVew: count > 0)
    }
    
    func didEndInteracting() {
        handleResultSetVisibility(makeVisible: false, isThisResultsVew: false)
    }
    
    func didSelectResult(withSearchCompletion: MKLocalSearchCompletion, _ coordinate: CLLocationCoordinate2D) {
        if currentPlacemark == nil {
            currentPlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 28.5383, longitude: -81.3792))
        }
        drawRoute(sourcePlacemark: currentPlacemark!, destinationPlacemark: MKPlacemark(coordinate: coordinate))
    }
}

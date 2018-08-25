//
//  SearchResultsVC.swift
//  HowtoVote
//
//  Created by Amir Fleminger on 8/15/18.
//  Copyright © 2018 Code for Orlando. All rights reserved.
//

import UIKit
import Pulley


class SearchResultsVC: UIViewController {
    // Dummy data
    let data:[String:Any] = [
        "election": Election(id: "0000", name: "Florida Primary Election", electionDay: Date(timeIntervalSinceReferenceDate: 557136000), ocdDivisionId: "divID01"),
        "votersAddress": Address(line1: "101 South Garland Avenue", line2: nil, line3: nil, city: "Orlando", state: "FL", zip: "32801"),
        "pollingLocations": [
            PollingLocation(id: "12345", name: "Election Office", address: Address(line1: "1500 E. Airport Blvd.", line2: nil, line3: nil, city: "Sanford", state: "FL", zip: "32773"), notes: nil),
            PollingLocation(id: "12346", name: "East Branch Library", address: Address(line1: "310 Division St.", line2: nil, line3: nil, city: "Oviedo", state: "FL", zip: "32765"), notes: nil)
        ]
    ]
    
    var pulleyController: PulleyViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mapViewController = MapViewController()
        let drawerContentVC = DrawerViewController(withData: data)
        drawerContentVC.delegate = mapViewController
        pulleyController = PulleyViewController(contentViewController: mapViewController, drawerViewController: drawerContentVC)
        pulleyController?.initialDrawerPosition = .partiallyRevealed
        view.addSubview(pulleyController!.view)
        addChildViewController(pulleyController!)
        pulleyController?.didMove(toParentViewController: self)
        let votersAddress = data["votersAddress"] as! Address
        mapViewController.showLocation(title: "Voter's address", address: votersAddress.fullAddress)
    }
    
}

import MapKit
fileprivate class MapViewController: UIViewController, MKMapViewDelegate, DrawerDelegate {
    // MARK: - Properties
    let mapView = MKMapView()
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapView()
        mapView.delegate = self
    }
    
    // MARK: - Auto layout
    func configureMapView(){
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    // MARK: - Drawer delegate
    func showLocation(title: String, address: String) {
        print("TODO: Center map at \(title)\naddress:\n\(address)")
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placmarks, error in
            if error != nil { print(error.debugDescription) }
            else {
                guard let placemark = placmarks?[0] else { return }
                let annotation = MKPointAnnotation()
                annotation.title = title
                annotation.coordinate = (placemark.location?.coordinate)!
                annotation.subtitle = address
                self.mapView.addAnnotation(annotation)
                self.mapView.showAnnotations([annotation], animated: true)
                self.mapView.selectAnnotation(annotation, animated: true)
            }
        }
    }
    
    // MARK: - Map View delegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
}

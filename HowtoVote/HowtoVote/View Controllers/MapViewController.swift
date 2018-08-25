//
//  MapViewController.swift
//  HowtoVote
//
//  Created by Amir Fleminger on 8/25/18.
//  Copyright © 2018 Code for Orlando. All rights reserved.
//

import MapKit
class MapViewController: UIViewController, MKMapViewDelegate, DrawerDelegate {
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

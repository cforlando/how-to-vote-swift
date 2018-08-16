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
    var pulleyController: PulleyViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainContentVC = PrimaryContentViewController()
        let drawerContentVC = DrawerViewController()
        
        pulleyController = PulleyViewController(contentViewController: mainContentVC, drawerViewController: drawerContentVC)
        view.addSubview(pulleyController!.view)
        addChildViewController(pulleyController!)
        pulleyController?.didMove(toParentViewController: self)
    }
    
}

import MapKit
fileprivate class PrimaryContentViewController: UIViewController{
    // MARK: - Properties
    let mapView = MKMapView()
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapView()
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
}

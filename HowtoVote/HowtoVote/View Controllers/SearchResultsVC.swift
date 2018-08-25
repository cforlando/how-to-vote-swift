//
//  SearchResultsVC.swift
//  HowtoVote
//
//  Created by Amir Fleminger on 8/15/18.
//  Copyright © 2018 Code for Orlando. All rights reserved.
//

import UIKit
import Pulley

/**
 Manages and shows the map and drawer view controllers using the Pulley 3rd party library
 */
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

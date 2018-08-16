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

class DrawerViewController: UIViewController {
    // MARK: - Properties
    let tableView = UITableView(frame: .zero, style: .grouped)
    let tableViewHeaders = ["Voter Address", "Election", "Polling Locations"]
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        configureGripperView()
//        configureTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureTableView()
        tableView.reloadData()
    }
    
    
    // MARK: - Views / layout
    
    
    func configureGripperView(){
        let gripperView = UIView(frame: .zero)
        gripperView.backgroundColor = .darkGray
        gripperView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gripperView)
        gripperView.widthAnchor.constraint(equalToConstant: 36).isActive = true
        gripperView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        gripperView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        gripperView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        gripperView.layer.cornerRadius = 2.5
        gripperView.layer.masksToBounds = true
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20.0).isActive = true
        let bottomAnchor = tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        bottomAnchor.isActive = true
//        bottomAnchor.priority = UILayoutPriority(rawValue: 999)
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        let trailingAnchor = tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        trailingAnchor.isActive = true
//        trailingAnchor.priority = UILayoutPriority(rawValue: 999)
    }
    

}
extension DrawerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        return cell

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewHeaders.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0, 1: // Voter address and election name
                return 1
            case 2:
                return 5 // TODO: return number of polling sites
            default:
                return 0
            }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableViewHeaders[section]
    }
}

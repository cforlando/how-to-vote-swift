//
//  DrawerViewController.swift
//  HowtoVote
//
//  Created by Amir Fleminger on 8/15/18.
//  Copyright © 2018 Code for Orlando. All rights reserved.
//

import UIKit

class DrawerViewController: UIViewController {
    // MARK: - Properties
    let tableView = UITableView(frame: .zero, style: .grouped)
    let tableViewHeaders = [ "Election", "Voter's Address", "Polling Locations"]
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        configureGripperView()
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
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    
}
extension DrawerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = "Florida Primary Election"
        case 1:
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = "101 South Garland Avenue\nOrlando\nFL, 32801"
        default:
            cell.textLabel?.text = "Polling location \(indexPath.row)"        }
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewHeaders.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1: // Election name and voter address
            return 1
        case 2:
            return 5 // TODO: return number of polling sites
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableViewHeaders[section]
    }
}

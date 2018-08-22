//
//  DrawerViewController.swift
//  HowtoVote
//
//  Created by Amir Fleminger on 8/15/18.
//  Copyright © 2018 Code for Orlando. All rights reserved.
//

import UIKit
import MapKit

enum ExternalMapsApp: String {
    case apple = "Apple Maps"
    case google = "Google Maps"
}

enum TableViewSection: Int {
    case election = 0, voterAddress, pollingLocations
}

class DrawerViewController: UIViewController {
    // MARK: - Properties
    let tableView = UITableView(frame: .zero, style: .plain)
    let tableViewHeaders = [ "Election", "Voter's Address", "Polling Locations"]
    
    // Dummy data
    let election = Election.init(id: "0000", name: "Florida Primary Election", electionDay: Date(timeIntervalSinceReferenceDate: 557136000), ocdDivisionId: "divID01")
    let votersAddress = Address(line1: "101 South Garland Avenue", line2: nil, line3: nil, city: "Orlando", state: "FL", zip: "32801")
    let pollingLocations = [
        PollingLocation.init(id: "12345", name: "Election Office", address: Address(line1: "1500 E. Airport Blvd.", line2: nil, line3: nil, city: "Sanford", state: "FL", zip: "32773"), notes: nil),
        PollingLocation.init(id: "12346", name: "East Branch Library", address: Address(line1: "310 Division St.", line2: nil, line3: nil, city: "Oviedo", state: "FL", zip: "32765"), notes: nil)
    ]

    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(PollingLocationCell.self, forCellReuseIdentifier: "pollingLocationCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 132
        tableView.rowHeight = UITableViewAutomaticDimension
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
    
    func showDirectionsInAppleMaps(toAddress: String, inMapsApp: ExternalMapsApp? = .apple){
        let baseURLStr = inMapsApp! == .google ? "comgooglemaps://" : "https://maps.apple.com/"
        
        let urlString = "\(baseURLStr)?saddr=\(votersAddress.fullAddress)&daddr=\(toAddress)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string: urlString) else { return }
        if (UIApplication.shared.canOpenURL(URL(string:baseURLStr)!)) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            NSLog("Can't open external maps app");
        }
    }
}
extension DrawerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "pollingLocationCell", for: indexPath) as! PollingLocationCell
            let pollingLocation:PollingLocation = pollingLocations[indexPath.row]
            
            cell.nameLabel.text = pollingLocation.name
            cell.addressLabel.text = pollingLocation.address.fullAddress
            cell.delegate = self
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.numberOfLines = 0
        switch TableViewSection(rawValue: indexPath.section) {
        case .election?:
            cell.textLabel?.text = election.name + "\n" + election.electionDay.toString()
            cell.selectionStyle = .none
        case .voterAddress?:
            cell.textLabel?.text = votersAddress.fullAddress
            cell.selectionStyle = .none
        default:
            cell.selectionStyle = .none
        }
        
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewHeaders.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch TableViewSection(rawValue: section) {
        case .election?, .voterAddress?:
            return 1
        case .pollingLocations?:
            return pollingLocations.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableViewHeaders[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected \(indexPath)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension DrawerViewController: PollingLocationCellDelegate {
    
    func showDirectionsToActionSheet(toAddress: String) {
        let optionMenu = UIAlertController(title: nil, message: "Get Directions", preferredStyle: .actionSheet)
 
        if (UIApplication.shared.canOpenURL(URL.init(string: "https://maps.apple.com/")!)) {
            let appleMapsAction = UIAlertAction(title: "Apple Maps", style: .default) {
                (alert: UIAlertAction!) -> Void in
                self.showDirectionsInAppleMaps(toAddress: toAddress, inMapsApp: .apple)
            }
            optionMenu.addAction(appleMapsAction)
        }
        if (UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!)) {
            let googleMapsAction = UIAlertAction(title: "Google Maps", style: .default) {
                (alert: UIAlertAction!) -> Void in
                self.showDirectionsInAppleMaps(toAddress: toAddress, inMapsApp: .google)
            }
            optionMenu.addAction(googleMapsAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true)
    }
    
    func getDirectionsTapped(_ sender: PollingLocationCell) {
        showDirectionsToActionSheet(toAddress: sender.addressLabel.text!)
    }
}

fileprivate extension Date
{
    func toString() -> String
    {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: self)
    }
    
}


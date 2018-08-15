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
    }
    

}

class PrimaryContentViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
    }
}

class DrawerViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
    }
}

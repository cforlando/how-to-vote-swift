//
//  PollingLocationCell.swift
//  HowtoVote
//
//  Created by Amir Fleminger on 8/20/18.
//  Copyright © 2018 Code for Orlando. All rights reserved.
//

import UIKit

protocol PollingLocationCellDelegate : class {
    func getDirectionsTapped(_ sender: PollingLocationCell)
}

class PollingLocationCell: UITableViewCell {
    weak var delegate: PollingLocationCellDelegate?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupViews()
        getDirectionsButton.addTarget(self, action: #selector(getDirections(_ :)), for: .touchUpInside)
    }
    
    @objc func getDirections(_ sender: UIButton?){
        delegate?.getDirectionsTapped(self)
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Location name"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "12345 st\nSanford\nFL, 11111"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let getDirectionsButton: UIButton = {
        let btn = UIButton.init(type: .system)
        btn.setTitle("Directions", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    func setupViews(){
        contentView.addSubview(nameLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(getDirectionsButton)
        
        let padding:CGFloat = 15
        nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: padding).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.75).isActive = true
        addressLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: padding).isActive = true
        addressLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.75).isActive = true
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[nameLabel]-8-[addressLabel]-|", options: [], metrics: nil, views:  ["nameLabel": nameLabel, "addressLabel": addressLabel]))
        
        getDirectionsButton.widthAnchor.constraint(lessThanOrEqualToConstant: 100.0).isActive = true
        getDirectionsButton.heightAnchor.constraint(lessThanOrEqualToConstant: 44).isActive = true
        getDirectionsButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -padding).isActive = true
        getDirectionsButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

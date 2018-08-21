//
//  PollingLocationCell.swift
//  HowtoVote
//
//  Created by Amir Fleminger on 8/20/18.
//  Copyright © 2018 Code for Orlando. All rights reserved.
//

import UIKit

class PollingLocationCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupViews()
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
    
    func setupViews(){
        contentView.addSubview(nameLabel)
        contentView.addSubview(addressLabel)
        
        let padding:CGFloat = 15
        nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: padding).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.75).isActive = true
        addressLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: padding).isActive = true
        addressLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.75).isActive = true
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[nameLabel]-8-[addressLabel]-|", options: [], metrics: nil, views: ["nameLabel": nameLabel, "addressLabel": addressLabel]))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

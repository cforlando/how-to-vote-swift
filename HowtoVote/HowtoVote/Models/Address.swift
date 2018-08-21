//
//  Address.swift
//  HowtoVote
//
//  Created by Amir Fleminger on 8/20/18.
//  Copyright © 2018 Code for Orlando. All rights reserved.
//

import Foundation

struct Address {
    let line1:String
    let line2:String?
    let line3:String?
    let city:String
    let state:String
    let zip:String
    var fullAddress:String {
        var address = line1
        if line2 != nil { address += " " + line2! }
        if line3 != nil { address += " " + line3! }
        address += "\n\(city),\n\(state), \(zip)"
        return address
    }
}

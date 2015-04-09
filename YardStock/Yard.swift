//
//  Yard.swift
//  YardStock
//
//  Created by Megan Ritchey on 4/3/15.
//  Copyright (c) 2015 Group4. All rights reserved.
//

import UIKit
import CoreLocation

class Yard: NSObject {
    var name: String
    var lat:CLLocationDegrees
    var long:CLLocationDegrees
    var address: String
    var city: String
    var contact: String
    var auctions = Array<Auction>()

    init(name: String, lat:CLLocationDegrees, long:CLLocationDegrees, address: String, city: String, contact: String){
        self.name = name
        self.lat = lat
        self.long = long
        self.address = address
        self.city = city
        self.contact = contact
    }
}

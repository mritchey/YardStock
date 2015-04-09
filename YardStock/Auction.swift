//
//  Auction.swift
//  YardStock
//
//  Created by Megan Ritchey on 4/8/15.
//  Copyright (c) 2015 Group4. All rights reserved.
//

import UIKit

class Auction: NSObject {
    var salesDate: String
    var time: String
    var livestock: String
    
    init(salesDate: String, time: String, livestock: String){
        self.salesDate = salesDate
        self.time = time
        self.livestock = livestock
    }
}

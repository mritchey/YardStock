//
//  Report.swift
//  YardStock
//
//  Created by Megan Ritchey on 5/6/15.
//  Copyright (c) 2015 Group4. All rights reserved.
//

import UIKit

class Report: NSObject {
    var id: Int
    var title: NSString
    var date: NSDate?
    var stockyard: NSString
    var auction: NSString
    var receipts: Int
    var weekOldReceipts: Int
    var yearOldReceipts: Int
    var summary: NSString
    var livestock: NSString
    var source: NSString
    
    init(id: Int, title: NSString, date: NSDate, stockyard: NSString, auction: NSString, receipts: Int, weekOldReceipts: Int, yearOldReceipts: Int, summary: NSString, livestock: NSString, source: NSString){
        self.id = id
        self.title = title
        self.date = date
        self.stockyard = stockyard
        self.auction = auction
        self.receipts = receipts
        self.weekOldReceipts = weekOldReceipts
        self.yearOldReceipts = yearOldReceipts
        self.summary = summary
        self.livestock = livestock
        self.source = source
    }
}

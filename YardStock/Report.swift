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
    var month: Int
    var day: Int
    var year: Int
    var stockyard: NSString
    var auction: NSString
    var receipts: Int
    var weekOldReceipts: Int
    var yearOldReceipts: Int
    var summary: NSString
    var livestock: NSString
    var source: NSString
    
    init(id: Int, title: NSString, month: Int, day: Int, year: Int, stockyard: NSString, auction: NSString, receipts: Int, weekOldReceipts: Int, yearOldReceipts: Int, summary: NSString, livestock: NSString, source: NSString){
        self.id = id
        self.title = title
        self.month = month
        self.day = day
        self.year = year
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

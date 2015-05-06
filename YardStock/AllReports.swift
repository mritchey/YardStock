//
//  AllReports.swift
//  YardStock
//
//  Created by Megan Ritchey on 5/6/15.
//  Copyright (c) 2015 Group4. All rights reserved.
//

import UIKit

class AllReports: NSObject {
    var reports = Array<Report>()
    
    func load(fromURLString: String, completionHandler: (AllReports, String?) -> Void){
        reports = Array<Report>()
        if let url = NSURL(string: fromURLString) {
            let urlRequest = NSMutableURLRequest(URL: url)
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(urlRequest, completionHandler: {
                (data, response, error) -> Void in
                if error != nil {
                    dispatch_async(dispatch_get_main_queue(), {
                        completionHandler(self, error.localizedDescription)
                    })
                } else {
                    self.parse(data, completionHandler: completionHandler)
                }
            })
            
            task.resume()
        } else {
            dispatch_async(dispatch_get_main_queue(), {
                completionHandler(self, "Invalid URL")
            })
        }
    }
    
    func parse(jsonData: NSData, completionHandler: (AllReports, String?) -> Void) {
        var jsonError: NSError?
        
        if let jsonResult = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as? NSArray {
            if (jsonResult.count > 0){
                for listReports in jsonResult {
                    if let reportId = listReports["id"] as? Int,
                        reportTitle = listReports["title"] as? NSString,
                        reportDate = listReports["Date"] as? NSDate,
                        reportStockyard = listReports["stockyard"] as? NSString,
                        reportAuction = listReports["auction"] as? NSString,
                        reportReceipts = listReports["receipts"] as? Int,
                        reportWeekOldReceipts = listReports["weekOldReceipts"] as? Int,
                        reportYearOldReceipts = listReports["yearOldReceipts"] as? Int,
                        reportSummary = listReports["summary"] as? NSString,
                        reportLivestock = listReports["livestock"] as? NSString,
                        reportSource = listReports["source"] as? NSString{
                            reports.append(Report(id: reportId, title: reportTitle, date: reportDate, stockyard: reportStockyard, auction: reportAuction, receipts: reportReceipts, weekOldReceipts: reportWeekOldReceipts, yearOldReceipts: reportYearOldReceipts, summary: reportSummary, livestock: reportLivestock, source: reportSource))
                        }
                }
                dispatch_async(dispatch_get_main_queue(), {
                    completionHandler(self, nil)
                })
            }
        } else {
            if let unwrappedError = jsonError {
                dispatch_async(dispatch_get_main_queue(), {
                    completionHandler(self, "\(unwrappedError)")
                })
            }
        }
    }

}

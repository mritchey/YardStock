//
//  Stockyards.swift
//  YardStock
//
//  Created by Megan Ritchey on 4/3/15.
//  Copyright (c) 2015 Group4. All rights reserved.
//

import UIKit
import CoreLocation

class Stockyards: NSObject {
    var yards = Array<Yard>()

    func load(fromURLString: String, completionHandler: (Stockyards, String?) -> Void){
        yards = Array<Yard>()
        if let url = NSURL(string: fromURLString) {
            var data = NSData(contentsOfFile: fromURLString)
            self.parse(data!, completionHandler: completionHandler)
        } else {
            dispatch_async(dispatch_get_main_queue(), {
                completionHandler(self, "Invalid URL")
            })
        }
    }
    
    func parse(jsonData: NSData, completionHandler: (Stockyards, String?) -> Void) {
        var jsonError: NSError?
        
        if let jsonResult = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as? NSDictionary {
            if (jsonResult.count > 0){
                if let stockyards = jsonResult["data"] as? NSArray {
                    for ListOYards in stockyards {
                        if let yardName = ListOYards["name"] as? String{
                            if let yardLat = ListOYards["lat"] as? CLLocationDegrees{
                                if let yardLong = ListOYards["long"] as? CLLocationDegrees{
                                    if let yardAddress = ListOYards["address"] as? String{
                                        if let yardCity = ListOYards["city"] as? String{
                                            if let yardContact = ListOYards["contact"] as? String{
                                                let yard = Yard(name: yardName, lat: yardLat, long: yardLong, address: yardAddress, city: yardCity, contact: yardContact)
                                                yards.append(yard)
                                                if let yardAuctions = ListOYards["auctions"] as? NSArray{
                                                    for yardAuction in yardAuctions{
                                                        if let saleDate = yardAuction["sale date"] as? String{
                                                            if let time = yardAuction["time"] as? String{
                                                                if let livestock = yardAuction["livestock"] as? String{
                                                                    yard.auctions.append(Auction(salesDate: saleDate, time: time, livestock: livestock))
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
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


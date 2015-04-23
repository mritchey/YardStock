//
//  YardsTableViewController.swift
//  YardStock
//
//  Created by Megan Ritchey on 4/1/15.
//  Copyright (c) 2015 Group4. All rights reserved.
//

import UIKit
import CoreLocation

class YardsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var StockyardsTable: UITableView!
    
    let prototypeCellIdentifier = "cell"
    var stockyards: Stockyards = Stockyards()
    var selectedYard: Yard?
    let urlString = NSBundle(forClass: YardsTableViewController.self).pathForResource("stockyards", ofType: "json")!
    var locationManager: CLLocationManager!
    var locationFixAchieved = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockyards.load(urlString) {
            (companies, errorString) -> Void in
            if let unwrappedErrorString = errorString {
                // can do something about error here
                println(unwrappedErrorString)
            } else {
                self.locationManager = CLLocationManager()
                self.locationManager.delegate = self
                if CLLocationManager.authorizationStatus() == .NotDetermined {
                    self.locationManager!.requestWhenInUseAuthorization()
                }
                if CLLocationManager.authorizationStatus() != .Restricted || CLLocationManager.authorizationStatus() != .Denied {
                    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                    self.locationManager.startUpdatingLocation()
                }
                self.stockyards.yards.sort({$0.city < $1.city})
                self.StockyardsTable.reloadData()
            }
        }
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 192/255, green: 120/255, blue: 26/255, alpha: 1.0)
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockyards.yards.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(prototypeCellIdentifier) as! UITableViewCell
        cell.textLabel?.text = stockyards.yards[indexPath.row].name
        if(locationFixAchieved){
            cell.detailTextLabel?.text = String(format: "\(stockyards.yards[indexPath.row].city) , MO | %.2f Miles", stockyards.yards[indexPath.row].distanceAway!)
        }
        else{
            cell.detailTextLabel?.text = stockyards.yards[indexPath.row].city + ", MO"
        }
        cell.detailTextLabel?.textColor = UIColor.grayColor()
        //code to set cell info
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedYard = stockyards.yards[indexPath.row]
        performSegueWithIdentifier("toStockyard", sender: self)
        
        //unhighlight selected cell upon return to stockyard page
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destViewController = segue.destinationViewController as! RecentReportViewController
        
        destViewController.stockyard = selectedYard
    }
    
    @IBAction func returnToYardList(segue: UIStoryboardSegue) {
    }
    
    override func viewDidAppear(animated: Bool) {
        navigationController?.navigationBar.topItem?.title = "Stockyards"
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if (locationFixAchieved == false) {
            locationFixAchieved = true
            var locationArray = locations as NSArray
            var locationObj = locationArray.lastObject as! CLLocation
            for yard in self.stockyards.yards {
                var location = CLLocation(latitude: yard.lat, longitude: yard.long)
                var distance = locationObj.distanceFromLocation(location) / 1609.34
                yard.setDistanceAway(distance)
            }
            self.stockyards.yards.sort({$0.distanceAway < $1.distanceAway})
            self.StockyardsTable.reloadData()
        }
    }
}

//
//  YardsTableViewController.swift
//  YardStock
//
//  Created by Megan Ritchey on 4/1/15.
//  Copyright (c) 2015 Group4. All rights reserved.
//

import UIKit

class YardsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var StockyardsTable: UITableView!
    let prototypeCellIdentifier = "cell"
    var stockyards: Stockyards = Stockyards()
    var selectedYard: Yard?
    let urlString = NSBundle(forClass: YardsTableViewController.self).pathForResource("stockyards", ofType: "json")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stockyards.load(urlString) {
            (companies, errorString) -> Void in
            if let unwrappedErrorString = errorString {
                // can do something about error here
                println(unwrappedErrorString)
            } else {
                //self.stockyards.yards.sort({$0.city > $1.city}) something like this for ordering on distance
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier(prototypeCellIdentifier) as UITableViewCell
        cell.textLabel?.text = stockyards.yards[indexPath.row].name
        cell.detailTextLabel?.text = stockyards.yards[indexPath.row].city + ", MO"
        //code to set cell info
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedYard = stockyards.yards[indexPath.row]
        performSegueWithIdentifier("toStockyard", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destViewController = segue.destinationViewController as RecentReportViewController
        
        destViewController.stockyard = selectedYard
    }
    
    @IBAction func returnToYardList(segue: UIStoryboardSegue) {
    }
}

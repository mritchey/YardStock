//
//  RecentReportViewController.swift
//  YardStock
//
//  Created by Megan Ritchey on 4/3/15.
//  Copyright (c) 2015 Group4. All rights reserved.
//

import UIKit

class RecentReportViewController: UIViewController {
    
    @IBOutlet weak var pageTitle: UINavigationItem!
    
    var stockyard: Yard?
    
    //@IBOutlet weak var Title: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.title = ""

        // Do any additional setup after loading the view.
    }
    
    //add nav title back
    override func viewWillDisappear(animated: Bool) {
        navigationController?.navigationBar.topItem?.title = "Stockyards"
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?
        
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCellWithIdentifier("infoCell", forIndexPath: indexPath) as? UITableViewCell
        }
        
        else if indexPath.row == 1 {
            cell = tableView.dequeueReusableCellWithIdentifier("segControlCell", forIndexPath: indexPath) as? UITableViewCell
        }
        
        else if indexPath.row == 2 {
            cell = tableView.dequeueReusableCellWithIdentifier("reportCell", forIndexPath: indexPath) as? UITableViewCell
        }
        
        return cell!
        
    }
    

    @IBAction func segChanged(sender: AnyObject) {
        let segControl = sender as! UISegmentedControl
        let selected = segControl.selectedSegmentIndex
        
        if selected == 0 {
            pageTitle.title = "Past Reports"
        }
        else if selected == 1 {
            pageTitle.title = "Recent Report"
        }
        else if selected == 2 {
            pageTitle.title = "Upcoming Auctions"
        }
    }
    
}

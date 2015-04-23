//
//  RecentReportViewController.swift
//  YardStock
//
//  Created by Megan Ritchey on 4/3/15.
//  Copyright (c) 2015 Group4. All rights reserved.
//

import UIKit

class RecentReportViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageTitle: UINavigationItem!

    var pageTopTitle = "Recent Report"
    var rowsAdded: [NSIndexPath] = []
    var segSelect: Int?
    var stockyard: Yard?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segSelect = 1
        rowsAdded.append(NSIndexPath(forRow: 2, inSection: 0))
        
        navigationController?.navigationBar.topItem?.title = ""
        
        //resize cells
        tableView.estimatedRowHeight = 89
        tableView.rowHeight = UITableViewAutomaticDimension
        
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
        if segSelect == 0 {
            return 3
        }
        else if segSelect == 1 {
            return 3
        }
        else if segSelect == 2 {
            return (2 + stockyard!.auctions.count)
        }
        else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?
        
        //remove separators for unused cells
        tableView.tableFooterView = UIView(frame:CGRectZero)
        
        if indexPath.row == 0 {
            let infoCell = tableView.dequeueReusableCellWithIdentifier("infoCell", forIndexPath: indexPath) as? InfoCellTableViewCell
            infoCell?.stockyardNameLabel.text = stockyard!.name
            infoCell?.addressLabel.text = stockyard!.address + ", " + stockyard!.city
            infoCell?.addressLabel.textColor = UIColor.grayColor()
            infoCell?.phoneLabel.text = stockyard!.contact
            infoCell?.phoneLabel.textColor = UIColor.grayColor()
            infoCell?.livestockLabel.text = stockyard!.livestock
            infoCell?.livestockLabel.textColor = UIColor.grayColor()
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
            cell = infoCell
            cell?.separatorInset = UIEdgeInsetsMake(0, 999, 0, 0)
        }
        
        else if indexPath.row == 1 {
            cell = tableView.dequeueReusableCellWithIdentifier("segControlCell", forIndexPath: indexPath) as? UITableViewCell
            cell?.separatorInset = UIEdgeInsetsMake(0, 999, 0, 0)
        }
        
        else if indexPath.row >= 2 {
            if segSelect == 1 {
                cell = tableView.dequeueReusableCellWithIdentifier("reportCell", forIndexPath: indexPath) as? UITableViewCell
                cell?.separatorInset = UIEdgeInsetsMake(0, 999, 0, 0)
            }
            else if segSelect == 0 {
                cell = tableView.dequeueReusableCellWithIdentifier("pastReportsCell", forIndexPath: indexPath) as? UITableViewCell
                
                cell!.detailTextLabel?.textColor = UIColor.grayColor()
            }
            else if segSelect == 2 {
                cell = tableView.dequeueReusableCellWithIdentifier("upcomingAuctionsCell", forIndexPath: indexPath) as? UITableViewCell
                cell!.textLabel!.text = stockyard!.auctions[indexPath.row - 2].livestock
                cell!.detailTextLabel!.text = stockyard!.auctions[indexPath.row - 2].salesDate + " | " + stockyard!.auctions[indexPath.row - 2].time
                
                //wrap cell text
                cell!.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
                cell!.textLabel?.numberOfLines = 0
                cell!.detailTextLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
                cell!.detailTextLabel?.numberOfLines = 0
                
                cell!.detailTextLabel?.textColor = UIColor.grayColor()
            }
        }
        
        cell!.setNeedsLayout()
        cell!.layoutIfNeeded()
        
        return cell!

    }
    //View report
//    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
//        performSegueWithIdentifier("toReportView", sender: self)
//    }
    
    @IBAction func segChanged(sender: AnyObject) {
        let segControl = sender as! UISegmentedControl
        let selected = segControl.selectedSegmentIndex
        var numCellsAdded = 0
        var auctions: [NSIndexPath] = []
        
        if selected == 0 {
            pageTopTitle = "Past Reports"
            pageTitle.title = pageTopTitle
            segSelect = 0
            tableView.beginUpdates()
            tableView.deleteRowsAtIndexPaths(rowsAdded, withRowAnimation: .Fade)
            tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 2, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Top)
            tableView.endUpdates()
            rowsAdded = [NSIndexPath(forRow: 2, inSection: 0)]
        }
        else if selected == 1 {
            pageTopTitle = "Recent Report"
            pageTitle.title = pageTopTitle
            segSelect = 1
            tableView.beginUpdates()
            tableView.deleteRowsAtIndexPaths(rowsAdded, withRowAnimation: .Fade)
            tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 2, inSection: 0)], withRowAnimation: .Top)
            tableView.endUpdates()
            rowsAdded = [NSIndexPath(forRow: 2, inSection: 0)]
        }
        else if selected == 2 {
            pageTopTitle = "Upcoming Auctions"
            pageTitle.title = pageTopTitle
            segSelect = 2
            tableView.beginUpdates()
            tableView.deleteRowsAtIndexPaths(rowsAdded, withRowAnimation: .Fade)
            
            for i in 2...(1 + stockyard!.auctions.count) {
                auctions.append(NSIndexPath(forRow: i, inSection: 0))
            }
                
            tableView.insertRowsAtIndexPaths(auctions, withRowAnimation: .Top)
            tableView.endUpdates()
            rowsAdded = auctions
        
        }
    }
    override func viewDidAppear(animated: Bool) {
        pageTitle.title = pageTopTitle
    }
}

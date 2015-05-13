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
    var allReports: AllReports = AllReports()
    let urlString = "http://yardstock.herokuapp.com/reports.json"
    var stockyardReports: [Report] = []
    var selectedReport: Report?
    var stockyard: Yard?
    
    var wentAway: Bool = false
    var numReports: Int?
    var segSelect: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //load all reports
        allReports.load(urlString) {
            (companies, errorString) -> Void in
            if let unwrappedErrorString = errorString {
                // can do something about error here
                println(unwrappedErrorString)
            }
        }
        
        //initialize rowsAdded
        rowsAdded.append(NSIndexPath(forRow: 2, inSection: 0))
            
        segSelect = 1
        
        //remove "Back" nav text
        navigationController?.navigationBar.topItem?.title = ""
        
        //resize cells
        tableView.estimatedRowHeight = 89
        tableView.rowHeight = UITableViewAutomaticDimension

    }
    
    //estimatedHeight Functions
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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
            if numReports > 0 {
                return (2 + numReports!)
            }
            else {
                return 3
            }
        }
        else if segSelect == 1 {
            if numReports > 0 {
                return 3
            }
            else {
                return 3
            }
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
                        
            cell = infoCell
            cell?.separatorInset = UIEdgeInsetsMake(0, 999, 0, 0)
        }
        
        else if indexPath.row == 1 {
            cell = tableView.dequeueReusableCellWithIdentifier("segControlCell", forIndexPath: indexPath) as? UITableViewCell
            cell?.separatorInset = UIEdgeInsetsMake(0, 999, 0, 0)
        }
        
        else if indexPath.row >= 2 {
            if segSelect == 0 {
                cell = tableView.dequeueReusableCellWithIdentifier("pastReportsCell", forIndexPath: indexPath) as? UITableViewCell
                
                cell!.detailTextLabel?.textColor = UIColor.grayColor()
                if numReports > 0 {
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "mm-dd-yyyy"
                    let reportDate = dateFormatter.stringFromDate(stockyardReports[indexPath.row - 2].date!)
                    
                    cell!.textLabel!.text = stockyardReports[indexPath.row - 2].title as String
                    cell!.detailTextLabel!.text = reportDate
                }
                else {
                    cell!.textLabel!.text = "No Reports Available"
                    cell!.detailTextLabel!.text = ""
                    cell!.accessoryType = UITableViewCellAccessoryType.None
                    cell!.selectionStyle = UITableViewCellSelectionStyle.None
                    cell!.userInteractionEnabled = false
                }
            }
                
            else if segSelect == 1 {
                cell = tableView.dequeueReusableCellWithIdentifier("reportCell", forIndexPath: indexPath) as? UITableViewCell
                if numReports > 0 {
                    
                    var mostRecentReport = stockyardReports[0]
                    for var x = 1; x < numReports; x++ {
                        if stockyardReports[x].date?.compare(stockyardReports[x - 1].date!) == NSComparisonResult.OrderedDescending {
                            mostRecentReport = stockyardReports[x]
                        }
                    }
                    
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "mm-dd-yyyy"
                    let mostRecentReportDate = dateFormatter.stringFromDate(mostRecentReport.date!)
                    cell!.textLabel!.text = (mostRecentReport.title as String) + "\n\n" + (mostRecentReport.auction as String) + "\n\n" + (mostRecentReportDate) + "\n\nReceipts: " + (String(mostRecentReport.receipts)) + "\n\nLast Week: " + (String(mostRecentReport.weekOldReceipts)) + "\n\nYear Ago: " + (String(mostRecentReport.yearOldReceipts)) + "\n\nSummary:\n" + (mostRecentReport.summary as String) + "\n\nLivestock:\n" + (mostRecentReport.livestock as String) + "\n\nSource:\n" + (mostRecentReport.source as String)
                }
                else {
                    cell!.textLabel!.text = "No Reports Available"
                    cell!.userInteractionEnabled = false
                }
            }
                
            else if segSelect == 2 {
                cell = tableView.dequeueReusableCellWithIdentifier("upcomingAuctionsCell", forIndexPath: indexPath) as? UITableViewCell
                cell!.textLabel!.text = stockyard!.auctions[indexPath.row - 2].livestock
                cell!.detailTextLabel!.text = stockyard!.auctions[indexPath.row - 2].salesDate + " | " + stockyard!.auctions[indexPath.row - 2].time
                
                cell!.detailTextLabel?.textColor = UIColor.grayColor()
            }
        }
        
        //wrap cell text
        cell!.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell!.textLabel?.numberOfLines = 0
        cell!.detailTextLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell!.detailTextLabel?.numberOfLines = 0
        
        cell!.setNeedsLayout()
        cell!.layoutIfNeeded()
        
        return cell!
    }
    
    //View report
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row > 1 {
            if segSelect == 0 {
                selectedReport = stockyardReports[indexPath.row - 2]
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        if tableView.cellForRowAtIndexPath(indexPath)?.reuseIdentifier == "pastReportsCell"
        {
            performSegueWithIdentifier("toViewReport", sender: self)
        }
    }
    
    //segmented control selection changed
    @IBAction func segChanged(sender: AnyObject) {
        let segControl = sender as! UISegmentedControl
        let selected = segControl.selectedSegmentIndex
        var auctions: [NSIndexPath] = []
        var pastReports: [NSIndexPath] = []
        var currentReport: [NSIndexPath] = []
        
        if selected == 0 {
            pageTopTitle = "Past Reports"
            pageTitle.title = pageTopTitle
            segSelect = 0
            tableView.beginUpdates()
            tableView.deleteRowsAtIndexPaths(rowsAdded, withRowAnimation: .Fade)
            rowsAdded = []
            
            if numReports > 0 {
                for i in 2...(1 + numReports!) {
                    pastReports.append(NSIndexPath(forRow: i, inSection: 0))
                    rowsAdded.append(NSIndexPath(forRow: i, inSection: 0))
                }
                tableView.insertRowsAtIndexPaths(pastReports, withRowAnimation: UITableViewRowAnimation.Top)
            }
            else {
                rowsAdded.append(NSIndexPath(forRow: 2, inSection: 0))
                tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 2, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Top)
            }
            
            tableView.endUpdates()
        }
        else if selected == 1 {
            pageTopTitle = "Recent Report"
            pageTitle.title = pageTopTitle
            segSelect = 1
            tableView.beginUpdates()
            tableView.deleteRowsAtIndexPaths(rowsAdded, withRowAnimation: .Fade)
            rowsAdded = []
            
            if numReports > 0 {
                currentReport.append(NSIndexPath(forRow: 2, inSection: 0))
                rowsAdded.append(NSIndexPath(forRow: 2, inSection: 0))
                tableView.insertRowsAtIndexPaths(currentReport, withRowAnimation: UITableViewRowAnimation.Fade)
            }
            else {
                rowsAdded.append(NSIndexPath(forRow: 2, inSection: 0))
                tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 2, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Top)
            }
            
            tableView.endUpdates()
        }
        else if selected == 2 {
            pageTopTitle = "Upcoming Auctions"
            pageTitle.title = pageTopTitle
            segSelect = 2
            tableView.beginUpdates()
            tableView.deleteRowsAtIndexPaths(rowsAdded, withRowAnimation: .Fade)
            rowsAdded = []
            
            for i in 2...(1 + stockyard!.auctions.count) {
                auctions.append(NSIndexPath(forRow: i, inSection: 0))
                rowsAdded.append(NSIndexPath(forRow: i, inSection: 0))
            }
                
            tableView.insertRowsAtIndexPaths(auctions, withRowAnimation: .Top)
            tableView.endUpdates()
        
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destViewController = segue.destinationViewController as! ViewReportTableViewController
        
        destViewController.report = selectedReport
    }
    
    override func viewDidAppear(animated: Bool) {
        
        //self.stockyardReports.sort({ $0.date!.compare($1.date!) == NSComparisonResult.OrderedAscending })
        self.allReports.reports.sort({ $0.date!.compare($1.date!) == NSComparisonResult.OrderedDescending })
        //initialize rowsAdded
        if wentAway == true {
            rowsAdded = []
            for i in 2...(1 + numReports!) {
                rowsAdded.append(NSIndexPath(forRow: i, inSection: 0))
            }
            print(rowsAdded.count)
            
            stockyardReports = []
            segSelect = 0
        }
        
        //get all the reports for this stockyard
        for var x = 0; x < allReports.reports.count; x++ {
            if allReports.reports[x].stockyard == stockyard!.name {
                stockyardReports.append(allReports.reports[x])
            }
        }
        
        numReports = stockyardReports.count
        
        if numReports > 0 && wentAway != true {
            tableView.reloadData()
        }
        
        pageTitle.title = pageTopTitle
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func viewDidDisappear(animated: Bool) {
        wentAway = true
    }


}

//
//  ViewReportTableViewController.swift
//  YardStock
//
//  Created by Megan Ritchey on 4/30/15.
//  Copyright (c) 2015 Group4. All rights reserved.
//

import UIKit

class ViewReportTableViewController: UITableViewController {

    var report: Report?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(report?.title)
        
        tableView.estimatedRowHeight = 89
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 3
        case 1:
            return 3
        case 2:
            return 1
        case 3:
            return 1
        case 4:
            return 1
        default:
            return 1
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell?
        switch indexPath.section{
        case 0:
            switch  indexPath.row{
            case 0:
                cell = tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath) as? UITableViewCell
                cell?.textLabel?.text = report!.title as String
//                cell?.textLabel?.text = "\(report?.title)"
            case 1:
                cell = tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath) as? UITableViewCell
                cell?.textLabel?.text = report!.auction as String
            case 2:
                
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "mm-dd-yyyy"
                let reportDate = dateFormatter.stringFromDate(report!.date!)
                
                cell = tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath) as? UITableViewCell
                cell?.textLabel?.text = reportDate
                
            default:
                cell = tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath) as? UITableViewCell
                cell?.textLabel?.text = "Error Occurred"
                //we can come up with something better here
            }
        case 1:
            switch  indexPath.row{
            case 0:
                cell = tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath) as? UITableViewCell
                cell?.textLabel?.text = "Receipts: " + String(report!.receipts)
                //this might take a little more to make the int a string
            case 1:
                cell = tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath) as? UITableViewCell
                cell?.textLabel?.text = "Week Ago: " + String(report!.weekOldReceipts)
                //this might take a little more to make the int a string
            case 2:
                cell = tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath) as? UITableViewCell
                cell?.textLabel?.text = "Year Ago: " + String(report!.yearOldReceipts)
                //this might take a little more to make the int a string
            default:
                cell = tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath) as? UITableViewCell
                cell?.textLabel?.text = "Error Occurred"
                //we can come up with something better here
            }
        case 2:
            let paragraphCell = tableView.dequeueReusableCellWithIdentifier("doubleLabelCell", forIndexPath: indexPath) as? DoubleLabelTableViewCell
            paragraphCell?.titleLabel.text = "Summary:"
            paragraphCell?.infoLabel.text = report!.summary as String
            paragraphCell?.infoLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
            paragraphCell?.infoLabel?.numberOfLines = 0
            cell = paragraphCell
        case 3:
            let paragraphCell = tableView.dequeueReusableCellWithIdentifier("doubleLabelCell", forIndexPath: indexPath) as? DoubleLabelTableViewCell
            paragraphCell?.titleLabel.text = "Livestock:"
            paragraphCell?.infoLabel.text = report!.livestock as String
            paragraphCell?.infoLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
            paragraphCell?.infoLabel?.numberOfLines = 0
            cell = paragraphCell
        case 4:
            let paragraphCell = tableView.dequeueReusableCellWithIdentifier("doubleLabelCell", forIndexPath: indexPath) as? DoubleLabelTableViewCell
            paragraphCell?.titleLabel.text = "Source:"
            paragraphCell?.infoLabel.text = report!.source as String
            paragraphCell?.infoLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
            paragraphCell?.infoLabel?.numberOfLines = 0
            cell = paragraphCell
        default:
            cell = tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath) as? UITableViewCell
            cell?.textLabel?.text = "Error Occurred"
            //we can come up with something better here
        }
        
        cell!.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell!.textLabel?.numberOfLines = 0
        cell!.detailTextLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell!.detailTextLabel?.numberOfLines = 0
        
        cell!.setNeedsLayout()
        cell!.layoutIfNeeded()
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

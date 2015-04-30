//
//  ViewReportTableViewController.swift
//  YardStock
//
//  Created by Megan Ritchey on 4/30/15.
//  Copyright (c) 2015 Group4. All rights reserved.
//

import UIKit

class ViewReportTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
                cell?.textLabel?.text = "PUT THE TITLE HERE"
            case 1:
                cell = tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath) as? UITableViewCell
                cell?.textLabel?.text = "PUT THE AUCTION NAME HERE"
            case 2:
                cell = tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath) as? UITableViewCell
                cell?.textLabel?.text = "PUT THE DATE HERE"
                //this might take a little more logic if it's not just a string
            default:
                cell = tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath) as? UITableViewCell
                cell?.textLabel?.text = "Error Occurred"
                //we can come up with something better here
            }
        case 1:
            switch  indexPath.row{
            case 0:
                cell = tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath) as? UITableViewCell
                cell?.textLabel?.text = "PUT THE RECEIPT HERE"
                //this might take a little more to make the int a string
            case 1:
                cell = tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath) as? UITableViewCell
                cell?.textLabel?.text = "PUT THE WEEK AGO HERE"
                //this might take a little more to make the int a string
            case 2:
                cell = tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath) as? UITableViewCell
                cell?.textLabel?.text = "PUT THE YEAR AGO HERE"
                //this might take a little more to make the int a string
            default:
                cell = tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath) as? UITableViewCell
                cell?.textLabel?.text = "Error Occurred"
                //we can come up with something better here
            }
        case 2:
            let paragraphCell = tableView.dequeueReusableCellWithIdentifier("doubleLabelCell", forIndexPath: indexPath) as? DoubleLabelTableViewCell
            paragraphCell?.titleLabel.text = "Summary:"
            paragraphCell?.infoLabel.text = "PUT THE SUMMARY HERE"
            cell = paragraphCell
        case 3:
            let paragraphCell = tableView.dequeueReusableCellWithIdentifier("doubleLabelCell", forIndexPath: indexPath) as? DoubleLabelTableViewCell
            paragraphCell?.titleLabel.text = "Livestock:"
            paragraphCell?.infoLabel.text = "PUT THE LIVESTOCK HERE"
            cell = paragraphCell
        case 4:
            let paragraphCell = tableView.dequeueReusableCellWithIdentifier("doubleLabelCell", forIndexPath: indexPath) as? DoubleLabelTableViewCell
            paragraphCell?.titleLabel.text = "Source:"
            paragraphCell?.infoLabel.text = "PUT THE SOURCE HERE"
            cell = paragraphCell
        default:
            cell = tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath) as? UITableViewCell
            cell?.textLabel?.text = "Error Occurred"
            //we can come up with something better here
        }
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

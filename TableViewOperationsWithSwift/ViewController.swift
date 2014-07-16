//
//  ViewController.swift
//  TableViewOperationsWithSwift
//
//  Created by Suryakant Sharma on 7/16/14.
//  Copyright (c) 2014 Suryakant. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var barButton   : UIBarButtonItem
    @IBOutlet var listTableView : UITableView
    
    //DataDource array
    var countryList:String[] = ["India","United States","Australia","Canada","France"]
    let kCellIdentifier:String  = "MyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //listTableView.editing = true;
        listTableView.dataSource = self;
        listTableView.delegate   = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func editTableView (sender:UIBarButtonItem)
    {
        if listTableView.editing{
            //listTableView.editing = false;
            listTableView.setEditing(false, animated: true);
            barButton.style = UIBarButtonItemStyle.Plain;
            barButton.title = "Edit";
            //listTableView.reloadData();
        }
        else{
            //listTableView.editing = true;
            listTableView.setEditing(true, animated: true);
            barButton.title = "Done";
            barButton.style =  UIBarButtonItemStyle.Done;
            //listTableView.reloadData();
        }
    }

    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        
//        var count = countryList.count;
//        if listTableView.editing{
//            count++;
//        }
        return countryList.count;
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as UITableViewCell!
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: kCellIdentifier)
        }
        
        /*var count = 0;
        if(listTableView.editing && indexPath.row != 0){
        count = 1;
        }
        
        if(indexPath.row == countryList.count && listTableView.editing){
            cell.text = "add new row";
            return cell;
        }*/
        
        cell.textLabel.text = countryList[indexPath.row]

        return cell
    }
    
    
    // The editing style for a row is the kind of button displayed to the left of the cell when in editing mode.
    func tableView(tableView: UITableView!, editingStyleForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCellEditingStyle
    {
        if (false == listTableView.editing && !indexPath){
            return UITableViewCellEditingStyle.None;
        }
        
        if (listTableView.editing && indexPath.row == countryList.count){
            return UITableViewCellEditingStyle.Insert;
        }
        else{
            return UITableViewCellEditingStyle.Delete;
        }
        //return UITableViewCellEditingStyle.None;
    }
    
    // Update the data model according to edit actions delete or insert.
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!)
    {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            countryList.removeAtIndex(indexPath.row);
            self.editTableView(barButton);
            listTableView.reloadData();
        }
        else if editingStyle == UITableViewCellEditingStyle.Insert{
            countryList.append("New Country");
        }
    }
    
    
    // Determine whether a given row is eligible for reordering or not.
   func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool
    {
        return true;
    }
    
    // Process the row move. This means updating the data model to correct the item indices.
    func tableView(tableView: UITableView!, moveRowAtIndexPath sourceIndexPath: NSIndexPath!, toIndexPath destinationIndexPath: NSIndexPath!)
    {
        let item : String = countryList[sourceIndexPath.row];
        countryList.removeAtIndex(sourceIndexPath.row);
        countryList.insert(item, atIndex: destinationIndexPath.row)
    }



}


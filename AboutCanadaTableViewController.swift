//
//  AboutCanadaTableViewController.swift
//  TestApp
//
//  Created by iqrar haider on 1/6/15.
//  Copyright (c) 2015 iqrar haider. All rights reserved.
//

import UIKit

class AboutCanadaTableViewController: UITableViewController {
    
    var results = [Data]()
    
   override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // To Display Row It's Own Contents
        self.tableView.estimatedRowHeight = 100.0;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        // Pull To Refresh Control
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = UIColor.whiteColor()
        refreshControl?.tintColor = UIColor.grayColor()
        refreshControl?.addTarget(self, action: "getResults", forControlEvents: UIControlEvents.ValueChanged)
        getResults()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return results.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as TableViewCell
        
        //Title updated from jSON 
        self.navigationItem.title = results[indexPath.row].name
        
        // Configure the cell...
        cell.titleLabel.text = results[indexPath.row].name
        cell.desplabel.text = results[indexPath.row].des
        cell.titleLabel.textColor = UIColor.blueColor()
        
        //Loads the images lazily
        dispatch_async(dispatch_get_main_queue(), {
            
            if let imgURL: NSURL = NSURL(string: self.results[indexPath.row].hrefString){
                
                // Download an NSData representation of the image at the URL
                if let imgData = NSData(contentsOfURL: imgURL){
                    cell.rightImage?.image = UIImage(data: imgData)
                    
                }
                
            }
        })
        
        return cell
    }
    
    func getResults() {
        
        let urlString = "https://api.myjson.com/bins/42be7"
        let url = NSURL(string: urlString)!
        let urlSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                println(error.localizedDescription)
            }
            
            // Parse JSON data
            self.results = self.JsonFromUrl(data)
            
            // Reload table view
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            })
            
            })
        
        task.resume()
    }
    
    func JsonFromUrl(data: NSData) -> [Data] {
        
        var results = [Data]()
        var error:NSError?
        
        let jsonData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as? NSDictionary
        
        // Return nil if there is any error
        if error != nil {
            println(error?.localizedDescription)
        }
        
        // Parse JSON data
        if let jsonrows = jsonData?["rows"] as? [AnyObject]{
            for jsonrow in jsonrows {
                
                if let name = jsonrow["title"] as? String{
                    
                    if let desp = jsonrow[ "description"] as? String{
                        
                        if let hrefString = jsonrow[ "imageHref" ] as? String{
                            let result = Data(name:name, des:desp, hrefString:hrefString)
                            results.append(result)
                        }
                    }
                }
            }
            
        }
        
        return results
   
    }
}
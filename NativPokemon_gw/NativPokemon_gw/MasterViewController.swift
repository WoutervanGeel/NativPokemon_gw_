//
//  MasterViewController.swift
//  NativPokemon_gw
//
//  Created by Wouter van Geel on 09/04/16.
//  Copyright © 2016 gijsbertvancorstanje_woutervangeel. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        
        // Haal het singleton session object op
        let session = NSURLSession.sharedSession()
        
        // Creëer een URL object op basis van een string
        let url = NSURL(string: "https://api.eet.nu/venues?query=den-bosch/")
        
        // Definieer een task voor de URL session om een GET request te doen.
        // Die krijgt een closure mee in de vorm van een completion handler.
        
        // De data zal asynchroon geladen worden, en de completion handler wordt aangeroepen
        // zodra de data binnen is. Binnen deze closure verwijzen we naar een instantievariabele,
        // dus moet er 'self' voorgezet worden om deze vanuit de closure te kunnen bereiken.
        
        // We willen de user interface aanpassen: de text view krijgt de data. Maar:
        // dat mag alleen in de main thread, terwijl de completion handler in een aparte thread
        // wordt aangroepen. Daarom wordt het statement dat de text view aanpast op
        // de main thread gezet, via de functie dispatch_async(), die als queue de main queue krijgt.
        let task = session.dataTaskWithURL(url!, completionHandler: {(data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if let theData = data {
                dispatch_async(dispatch_get_main_queue(), {
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    //self.textView.text = NSString(data: theData, encoding: NSUTF8StringEncoding) as! String
                        //let jsonResult = NSString(data: theData, encoding: NSUTF8StringEncoding) as! String
                    do{
                        //let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers) as! NSDictionary
                        let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                        let results = jsonDictionary["results"] as! NSArray
                        
                        for venue in results {
                            let id = venue["id"] as! Int
                            let name = venue["name"] as! String
                            var category: String
                            var telephone: String
                            var website_url: String
                            var tagline: String
                            
                            if(venue["category"] is NSNull){
                                category = "anonymous"
                            } else {
                                category = venue["category"] as! String
                            }
                            
                            if(venue["telephone"] is NSNull){
                                telephone = "anonymous"
                            } else {
                                telephone = venue["telephone"] as! String
                            }
                            
                            if(venue["website_url"] is NSNull){
                                website_url = "anonymous"
                            } else {
                                website_url = venue["website_url"] as! String
                            }
                            
                            if(venue["tagline"] is NSNull){
                                tagline = "anonymous"
                            } else {
                                tagline = venue["tagline"] as! String
                            }
                            
                            var tempVenue = Venue(_id: id, _name: name, _category: category, _telephone: telephone, _website_url: website_url, _tagline: tagline)
                            
                            
                            self.insertNewVenue(tempVenue)
                        }
                        
                    } catch {
                        
                    }
                    
                })
            }
        })
        
        // We moeten de taak nog wel starten!
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        task.resume()
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertNewVenue(venue: Venue) {
        objects.insert(venue, atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! Venue
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = objects[indexPath.row] as! Venue
        cell.textLabel!.text = object.name
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}


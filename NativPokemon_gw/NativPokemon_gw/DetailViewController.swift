//
//  DetailViewController.swift
//  NativPokemon_gw
//
//  Created by Wouter van Geel on 09/04/16.
//  Copyright © 2016 gijsbertvancorstanje_woutervangeel. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {


    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailCategoryLabel: UILabel!
    @IBOutlet weak var detailTaglineLabel: UILabel!
    @IBOutlet weak var detailWebsiteUrlLabel: UILabel!
    @IBOutlet weak var detailFavoriteLabel: UILabel!


    var detailItem: Venue! {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let nameLabel = self.detailNameLabel {
                nameLabel.text = detail.name
            }
        }
        
        if let detail = self.detailItem {
            if let favoriteLabel = self.detailFavoriteLabel {
                //NSUserDefaults.standardUserDefaults().setInteger(1, forKey: "favorite")
                //if(NSUserDefaults.standardUserDefaults().integerForKey("favorite") != nil){
                    if(NSUserDefaults.standardUserDefaults().integerForKey("favorite") == detail.id){
                        favoriteLabel.text = "favorite"
                    } else {
                        favoriteLabel.text = ""
                    }
                //} else {
                //    favoriteLabel.text = ""
                //}
            }
        }
        
        if let detail = self.detailItem {
            if let categoryLabel = self.detailCategoryLabel {
                categoryLabel.text = detail.category
            }
        }
        
        if let detail = self.detailItem {
            if let taglineLabel = self.detailTaglineLabel {
                taglineLabel.text = detail.tagline
            }
        }
        
        if let detail = self.detailItem {
            if let websiteLabel = self.detailWebsiteUrlLabel {
                websiteLabel.text = detail.website_url
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func telephoneCall(sender: AnyObject) {
        if(!(self.detailItem.telephone == "anonymous")){
            let phoneNumber = self.detailItem.telephone
            print("calling: \(phoneNumber)")
            if let phoneCallURL:NSURL = NSURL(string: "tel://\(phoneNumber)"){
                let application:UIApplication = UIApplication.sharedApplication()
                if (application.canOpenURL(phoneCallURL)) {
                    application.openURL(phoneCallURL);
                }
            }
        }
        
        
        //if not anonymous!
        
    }
    
    @IBAction func favoriteCall(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setInteger(self.detailItem.id, forKey: "favorite")
        self.configureView()
    }

}


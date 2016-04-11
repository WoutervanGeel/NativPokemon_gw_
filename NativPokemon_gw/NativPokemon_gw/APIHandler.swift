//
//  APIHandler.swift
//  NativPokemon_gw
//
//  Created by Wouter van Geel on 09/04/16.
//  Copyright © 2016 gijsbertvancorstanje_woutervangeel. All rights reserved.
//

import Foundation

class APIHandler {
    
    let globalUrl = "https://api.eet.nu/"
    
    
    //getting information about a single venue
    func getSingleVenue( _id: Int ){
        // This makes the GET call to httpbin.org. It simply gets the IP address and displays it on the screen.
        
        // Setup the session to make REST GET call.  Notice the URL is https NOT http!!
        let postEndpoint: String = globalUrl + "venues/" + String(_id)
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: postEndpoint)!
        
        // Make the POST call and handle it in a completion handler
        session.dataTaskWithURL(url, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            // Make sure we get an OK response
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 200 else {
                    print("Not a 200 response")
                    return
            }
            
            // Read the JSON
            do {
                if let ipString = NSString(data:data!, encoding: NSUTF8StringEncoding) {
                    // Print what we got from the call
                    print(ipString)
                    
                    // Parse the JSON to get the IP
                    let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    let id = jsonDictionary["id"] as! Int
                    let name = jsonDictionary["name"] as! String
                    let category = "testCategory"
                    let telephone = "testTelephone"
                    let website_url = "testWebsite_url"
                    let tagline = "testTagline"
                    
                    //let category = jsonDictionary["category"] as! String
                    //let telephone = jsonDictionary["telephone"] as! String
                    //let website_url = jsonDictionary["website_url"] as! String
                    //let tagline = jsonDictionary["tagline"] as! String
                    
                    let address = Address(_street: "testStreet", _zipcode: "testZipcode", _city: "testCity", _region: "testRegion", _country: "testCountry")
                    let geolocation = Geolocation(_latitude: 1.0101010101, _longitude: 2.0202020202)
                    //let address = jsonDictionary["address"] as! String
                    //let address = Address(_street: "Heuvel 20", _zipcode: "5038 CP", _city: "Tilburg", _region: "Noord-Brabant", _country: "The Netherlands")
                    //let geolocation = Geolocation(_latitude: 51.5576848, _longitude: 5.090147)
                    
                    var tempVenue = Venue(_id: id, _name: name, _category: category, _telephone: telephone, _website_url: website_url, _tagline: tagline, _address: address, _geolocation: geolocation)
                    
                    print(tempVenue)
                    //self.performSelectorOnMainThread("updateIPLabel:", withObject: origin, waitUntilDone: false)
                }
            } catch {
                print("bad things happened")
            }
        }).resume()
    }
}
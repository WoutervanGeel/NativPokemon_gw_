//
//  Venue.swift
//  NativPokemon_gw
//
//  Created by Wouter van Geel on 09/04/16.
//  Copyright © 2016 gijsbertvancorstanje_woutervangeel. All rights reserved.
//

import Foundation

class Venue {
    let id: Int
    let name: String
    let category: String
    let telephone: String
    let website_url: String
    let tagline: String
    let address: Address
    let geolocation: Geolocation
    
    init(_id: Int, _name: String, _category: String, _telephone: String, _website_url: String, _tagline: String, _address: Address, _geolocation: Geolocation){
        
        id = _id
        name = _name
        category = _category
        telephone = _telephone
        website_url = _website_url
        tagline = _tagline
        address = _address
        geolocation = _geolocation
        
    }
    
}
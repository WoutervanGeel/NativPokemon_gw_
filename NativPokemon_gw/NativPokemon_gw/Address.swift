//
//  Address.swift
//  NativPokemon_gw
//
//  Created by Wouter van Geel on 09/04/16.
//  Copyright © 2016 gijsbertvancorstanje_woutervangeel. All rights reserved.
//

import Foundation

class Address {
    let street: String
    let zipcode: String
    let city: String
    let region: String
    let country: String
    
    init(_street: String, _zipcode: String, _city: String, _region: String, _country: String){
        
        street = _street
        zipcode = _zipcode
        city = _city
        region = _region
        country = _country
    }
}
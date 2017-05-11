//
//  Location.swift
//  RainyShinyCloudy
//
//  Created by Osie G on 11/24/16.
//  Copyright © 2016 Osie G. All rights reserved.
//

import CoreLocation

class Location {
    
    static var sharedInstance = Location()
    var latitude: Double!
    var longitude: Double!
    
    private init () {
        
    }
    
}

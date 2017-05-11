//
//  Constants.swift
//  RainyShinyCloudy
//
//  Created by Osie G on 11/23/16.
//  Copyright © 2016 Osie G. All rights reserved.
//

import Foundation


let baseURL = "http://api.openweathermap.org/data/2.5/weather?"
let latitude = "lat="
let longitude = "&lon="
let app_id = "&appid="
let api_key = "0ddfec5c10dbf0f37482524d66aa595e"
typealias DownloadComplete = () -> ()

let currentURL = "http://api.openweathermap.org/data/2.5/forecast?lat=\(Location.sharedInstance.latitude)&lon=\(Location.sharedInstance.longitude)&appid=0ddfec5c10dbf0f37482524d66aa595e"
let forecastURL = "http://api.openweathermap.org/data/2.5/forecast?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=0ddfec5c10dbf0f37482524d66aa595e"

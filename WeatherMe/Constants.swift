//
//  Constants.swift
//  WeatherMe
//
//  Created by Ceasar Barbosa on 8/6/16.
//  Copyright © 2016 Ceasar Barbosa. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "c725fdd3a8ec3f848fa2367d5a27d444"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=c725fdd3a8ec3f848fa2367d5a27d444"
let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=10&mode=json&appid=c725fdd3a8ec3f848fa2367d5a27d444"





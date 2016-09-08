//
//  Location.swift
//  WeatherMe
//
//  Created by Ceasar Barbosa on 8/8/16.
//  Copyright © 2016 Ceasar Barbosa. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
    
}

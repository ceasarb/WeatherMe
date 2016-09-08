//
//  CurrentWeather.swift
//  WeatherMe
//
//  Created by Ceasar Barbosa on 8/6/16.
//  Copyright © 2016 Ceasar Barbosa. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    
    private var _cityName: String!
    private var _date: String!
    private var _weatherCondition: String!
    private var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = "Nothing"
        }
        
        return _cityName
    }
    
    var date: String{
        if _date == nil {
            _date = "Nothing"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    
    var weatherCondition: String {
        if _weatherCondition == nil {
            _weatherCondition = "Nothing"
        }
    
        return _weatherCondition
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        
        return _currentTemp
    }
    
    
    func downloadWeatherDetails(completed: DownloadComplete) {
        //Alamofire download
        Alamofire.request(.GET, CURRENT_WEATHER_URL).responseJSON { response in
            let result = response.result
            
            // Grabbing entire dictionary
            if let dict = result.value as? Dictionary<String,AnyObject> {
                
                // Parsing city name from dictionary
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                    print(self._cityName)
                }
                
                // Parsing weather from dictionary
                if let weather = dict["weather"] as? [Dictionary<String,AnyObject>] {
                    
                    if let main = weather[0]["main"] as? String {
                        self._weatherCondition = main.capitalized
                        print(self._weatherCondition)
                    }
                }
                
                // Parsing current temp from dictionary
                if let main = dict["main"] as? Dictionary<String,AnyObject> {
                    
                    if let temp = main["temp"] as? Double {
                        
                        let kelvinToFahrenheitPreDivision = (temp * (9/5) - 459.67)
                        
                        let kelvinToFahrenheit = Double(round(10 * kelvinToFahrenheitPreDivision)/10)
                        
                        self._currentTemp = kelvinToFahrenheit
                        print(self._currentTemp)
                    }
                }
            }
            
            completed()
        }
        
    }
    
}

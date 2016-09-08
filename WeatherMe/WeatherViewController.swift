//
//  WeatherViewController.swift
//  WeatherMe
//
//  Created by Ceasar Barbosa on 8/5/16.
//  Copyright © 2016 Ceasar Barbosa. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    //MARK: - @IBOutlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherConditionLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherConditionImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        currentWeather = CurrentWeather()
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            print(Location.sharedInstance.latitude, Location.sharedInstance.longitude)
            currentWeather.downloadWeatherDetails {
                self.downloadForecastData {
                    self.updateMainUI()
                }
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func downloadForecastData(completed: DownloadComplete) {
        // Downloading forecast data for Table View
        let forecastURL = URL(string: FORECAST_URL)!
        
        Alamofire.request(.GET, forecastURL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String,AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String,AnyObject>] {
                    
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print(obj)
                    }
                    self.forecasts.removeFirst()
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherTableViewCell {
            
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forcast: forecast)
            
            return cell
            
        } else {
            return WeatherTableViewCell()
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }

    func updateMainUI() {
        dateLabel.text = currentWeather.date
        temperatureLabel.text = "\(currentWeather.currentTemp)"
        cityLabel.text = currentWeather.cityName
        weatherConditionLabel.text = currentWeather.weatherCondition
        weatherConditionImage.image = UIImage(named: currentWeather.weatherCondition)
    }
    
}

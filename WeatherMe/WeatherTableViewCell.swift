//
//  WeatherTableViewCell.swift
//  WeatherMe
//
//  Created by Ceasar Barbosa on 8/5/16.
//  Copyright © 2016 Ceasar Barbosa. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherConditionImage: UIImageView!
    
    @IBOutlet weak var weatherConditionLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(forcast: Forecast) {
        dayLabel.text = forcast.date
        highTempLabel.text = forcast.highTemp
        lowTempLabel.text = forcast.lowTemp
        weatherConditionLabel.text = forcast.weatherCondition
        weatherConditionImage.image = UIImage(named: forcast.weatherCondition)
    }

}

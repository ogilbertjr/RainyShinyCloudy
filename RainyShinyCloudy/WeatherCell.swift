//
//  WeatherCell.swift
//  RainyShinyCloudy
//
//  Created by Osie G on 11/23/16.
//  Copyright © 2016 Osie G. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    
    func configureCell(forecast: Forecast) {
        lowTemp.text = "\(forecast._lowTemp)"
        highTemp.text = "\(forecast._highTemp)"
        dayLabel.text = forecast.date
        weatherType.text = forecast._weatherType
        weatherIcon.image = UIImage(named: forecast.weatherType)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}

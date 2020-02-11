//
//  WeatherTableViewCell.swift
//  TestApp(Anastasia)
//
//  Created by Ерлан Султанов on 2/10/20.
//  Copyright © 2020 Ерлан Султанов. All rights reserved.
//

import Foundation
import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupData(data: CityWeather) {
        cityLabel.text = data.name
        tempLabel.text = "\(data.temp.rounded())℃"
    }
}

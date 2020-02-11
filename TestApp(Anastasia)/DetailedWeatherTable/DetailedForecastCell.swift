//
//  DetailedForecastCell.swift
//  TestApp(Anastasia)
//
//  Created by Ерлан Султанов on 2/10/20.
//  Copyright © 2020 Ерлан Султанов. All rights reserved.
//

import Foundation
import UIKit


class DetailedForecastCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupData(data: CityWeatherForecast ) {
        dateLabel.text = data.date
        tempLabel.text = "\(data.temp.rounded())℃"
    }
}

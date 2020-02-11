//
//  CityWeatherForecast.swift
//  TestApp(Anastasia)
//
//  Created by Ерлан Султанов on 2/10/20.
//  Copyright © 2020 Ерлан Султанов. All rights reserved.
//

import Foundation
import RealmSwift


struct CityWeatherForecast {
    
    var date: String
    var temp: Double
    
    init(date: String, temp: Double) {
        self.date = date
        self.temp = temp
    }
}

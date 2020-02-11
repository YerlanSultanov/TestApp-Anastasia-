//
//  CityWeather.swift
//  TestApp(Anastasia)
//
//  Created by Ерлан Султанов on 2/10/20.
//  Copyright © 2020 Ерлан Султанов. All rights reserved.
//

import Foundation
import RealmSwift

class CityWeather: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var temp = 0.0
    @objc dynamic var isCityExist = true
    
    override static func primaryKey() -> String? {
        return "name"
    }
}

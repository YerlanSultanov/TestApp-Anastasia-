//
//  WeatherTableVM.swift
//  TestApp(Anastasia)
//
//  Created by Ерлан Султанов on 2/10/20.
//  Copyright © 2020 Ерлан Султанов. All rights reserved.
//

import Foundation
import RealmSwift
import Moya
import SwiftyJSON

class WeatherTableVM {
    
    let provider = MoyaProvider<MyServerApi>(plugins: [CompleteUrlLoggerPlugin()])
    var database: Realm
    typealias Action = () -> ()
    
    init() {
        database = try! Realm()
    }
    
    func getRequaredCities() {
        let requaredCities = ["Moscow","Bangkok"]
        for city in requaredCities {
            getCityWeatherData(city: city, completion: { message in return })
        }
    }
    
    
    func getCityWeatherData(city: String, completion: @escaping (_ message: String) -> Void) {
        provider.request(MyServerApi.getCityWeatherRequest(city: city), completion: {result in
            result.analysis(ifSuccess: { response in
                guard let json = try? JSON(data: response.data) else { return }
                if json["cod"].stringValue == "200" {
                    let object = CityWeather()
                    object.name = json["name"].stringValue
                    object.temp = json["main"]["temp"].doubleValue - 273.15
                    object.isCityExist = true
                    self.addDataToCityWeatherModel(object: object)
                    completion("City has been added")
                } else {
                    completion("City not found")
                }
            }, ifFailure: {_ in
            })
        })
    }
    
    func addDataToCityWeatherModel(object: CityWeather) {
        try! database.write {
            database.add(object, update: .all)
        }
    }
    
    func deleteObject(object: CityWeather, completion: Action?) {
        try! database.write {
            database.delete(object)
        }
        completion!()
    }
}


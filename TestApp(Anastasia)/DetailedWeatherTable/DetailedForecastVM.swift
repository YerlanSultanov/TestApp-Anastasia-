//
//  DetailedTableVM.swift
//  TestApp(Anastasia)
//
//  Created by Ерлан Султанов on 2/10/20.
//  Copyright © 2020 Ерлан Султанов. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON
import RealmSwift

class DetailedForecastVM {
    
    let provider = MoyaProvider<MyServerApi>()
    var forecastData = [CityWeatherForecast]()
    typealias Action = () -> ()
    
    func getForecastData(city: String, completion: Action?) {
        provider.request(MyServerApi.getForecastWeatherRequest(city: city), completion: { result in
                   result.analysis(ifSuccess: { response in
                       guard let json = try? JSON(data: response.data) else { return }
                    let listArray = json["list"].arrayValue
                
                    for forecastItem in listArray {
                        let date = self.convertDate(date: forecastItem["dt_txt"].stringValue)
                        let forecastObject = CityWeatherForecast(date: date, temp: forecastItem["main"]["temp"].doubleValue - 273.15)
                        self.forecastData.append(forecastObject)
                    }
                    completion!()
                    
                   }, ifFailure: {_ in
                       
                   })
               })
    }
    
    func convertDate(date: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let stringDate = formatter.date(from: date) else { return "" }
        formatter.dateFormat = "MMM d, h:mm a"
        let convertedDate = formatter.string(from: stringDate)
        return convertedDate
    }
    
}

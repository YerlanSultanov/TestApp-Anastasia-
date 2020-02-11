//
//  MyServerApi.swift
//  TestApp(Anastasia)
//
//  Created by Ерлан Султанов on 2/10/20.
//  Copyright © 2020 Ерлан Султанов. All rights reserved.
//

import Foundation
import Moya

enum MyServerApi {
    case getCityWeatherRequest(city: String)
    case getForecastWeatherRequest(city: String)
}

class CompleteUrlLoggerPlugin : PluginType {
    func willSend(_ request: RequestType, target: TargetType) {
        print(request.request?.url?.absoluteString ?? "Something is wrong")
    }
}

extension MyServerApi: TargetType, AccessTokenAuthorizable {
    var baseURL: URL {
        switch self {
        case .getCityWeatherRequest:
            return URL(string: "https://api.openweathermap.org/data/2.5/weather")!
        case .getForecastWeatherRequest:
            return URL(string: "https://api.openweathermap.org/data/2.5/forecast")!
        }
    }
    
    var path: String {
        switch self {
        case .getCityWeatherRequest:
            return ""
        case .getForecastWeatherRequest:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCityWeatherRequest:
            return .post
        case .getForecastWeatherRequest:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getCityWeatherRequest(let city):
            return .requestParameters(parameters: ["q":city,"appid":"0af23361935a5a992356488460a5255f"], encoding: URLEncoding.queryString)
        case .getForecastWeatherRequest(let city):
            return .requestParameters(parameters: ["q":city,"appid":"0af23361935a5a992356488460a5255f"], encoding: URLEncoding.queryString)
        }

    }
    
    var headers: [String : String]? {
        switch self {
        case .getCityWeatherRequest:
            return ["":""]

        case .getForecastWeatherRequest:
            return ["":""]
        }
    }
    
    var authorizationType: AuthorizationType {
        switch self {
        case .getCityWeatherRequest:
            return .none
        case .getForecastWeatherRequest:
            return .none
        }
    }
}

//
//  File.swift
//  weatherApp
//
//  Created by Ebbyy on 2022/08/14.
//

import Foundation
import SwiftUI

struct WeatherResponseEntity: Codable {
    let list: [List]
    let city: City
}

struct City: Codable {
    let id: Int
    let name: String
    let country: String
}

struct List: Codable {
    let weather: [WeatherEntity]
    let main: MainWeatherEntity
    let visibility: Int
    let wind: WindEntity
    let dt_txt: String
}

struct WeatherEntity: Codable {
    var id: Int
    var main: String
    var description: String
}

struct MainWeatherEntity: Codable {
    var temp: Float
    var feels_like: Float
    var temp_min: Float
    var temp_max: Float
    var humidity: Int
}

struct WindEntity: Codable {
    var speed: Double
}

enum WeatherCode: String, Codable {
    case thunderstorm = "200"
    case drizzle = "3"
    case rain = "5"
    case snow = "6"
    case atmosphere = "7"
    case clear = "800"
    case clouds = "8"
    case partly_cloudy = "801"
    
    
    var desc: String {
        switch self {
        case .clear:
                return "Clear"
        case .drizzle:
            return "Drizzle"
        case .rain:
            return "Rain"
        case .snow:
            return "Snow"
        case .atmosphere:
            return "Atmosphere"
        case .clouds:
            return "Cloudy"
        case .thunderstorm:
            return "Thunderstorm"
        case .partly_cloudy:
            return "Partly Cloudy"
        }
    }
    
    var image: Image {
        switch self {
        case .clear:
            return Image("slight_touch_happyday")
        case .drizzle:
            return Image("rainy")
        case .rain:
            return Image("rainy")
        case .snow:
            return Image("snowy")
        case .atmosphere:
            return Image("cloudy")
        case .clouds:
            return Image("cloudy")
        case .thunderstorm:
            return Image("thnderstorm")
        case .partly_cloudy:
            return Image("partly_cloudy")
        }
    }
}

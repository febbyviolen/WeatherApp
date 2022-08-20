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
    let pressure: Int
}

struct WindEntity: Codable {
    let speed: Double
    let deg: Int
}

struct WeatherInfoCurrent: Identifiable{
    var id = UUID()
    
    let city: String
    let dt_txt: String
    let temp: Float
    let humidity: Int
    let pressure: Int
    let speed: Double
    let description: MainDesc
    let main: String
}

struct WeatherInfoHourly: Identifiable, Hashable{
    var id = UUID()
    
    let dt_txt: String
    let temp: Float
    let description: MainDesc
}


enum MainDesc: String, Codable {
    case thunderstorm = "Thunderstorm"
    case drizzle = "Drizzle"
    case rain = "Rain"
    case snow = "snow"
    case atmosphere = "Atmosphere"
    case clear = "Clear"
    case clouds = "Clouds"
    case partly_cloudy = "Partly Cloudy"
    
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
            return "Clouds"
        case .thunderstorm:
            return "Thunderstorm"
        case .partly_cloudy:
            return "Partly_cloudy"
        }
    }
    
    var image: Image {
        switch self {
        case .clear:
            return Image("slight_touch_happyday")
        case .drizzle:
            return Image("rainy")
        case .rain:
            return Image("raindrops")
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

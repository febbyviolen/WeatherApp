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

struct DailyWeatherResponseEntity: Codable {
    let list: [ListDaily]
}

struct ListDaily: Codable {
    let temp: Temp
    let dt: Int
    let weather: [WeatherEntity]
}

struct Temp: Codable {
    let min: Double
    let max: Double
    
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
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
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
    let temp: Double
    let humidity: Int
    var feels_like: Double
    let speed: Double
    let description: MainDesc
    let main: String
    let country: String
}

struct WeatherInfoHourly: Identifiable, Hashable{
    var id = UUID()
    
    let dt_txt: String
    let temp: Double
    let description: MainDesc
}

struct WeatherInfoDaily: Identifiable, Hashable{
    var id = UUID()
    
    let dt: Int
    let max: Double
    let min: Double
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
            return Image("sunny")
        case .drizzle:
            return Image("drizzle")
        case .rain:
            return Image("drizzle")
        case .snow:
            return Image("snow")
        case .atmosphere:
            return Image("fog")
        case .clouds:
            return Image("mostly-cloudy")
        case .thunderstorm:
            return Image("thunderstorms")
        case .partly_cloudy:
            return Image("cloudy")
        }
    }
    
    var image2: Image {
        switch self {
        case .clear:
            return Image("sunnyIcon")
        case .drizzle:
            return Image("rainIcon")
        case .rain:
            return Image("rainIcon")
        case .snow:
            return Image("snowIcon")
        case .atmosphere:
            return Image("windyCloudyIcon")
        case .clouds:
            return Image("cloudyIcon")
        case .thunderstorm:
            return Image("thunderstormIcon")
        case .partly_cloudy:
            return Image("cloudyIcon")
        }
    }
}

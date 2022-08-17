//
//  WeatherAPIClient.swift
//  weatherApp
//
//  Created by Ebbyy on 2022/08/14.
//

import Foundation
import CoreLocation
import SwiftUI

final class WeatherAPIClient: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var currentWeather: Weather?
    
    private let locationManager = CLLocationManager()
    private let dateFormatter = ISO8601DateFormatter()
    
    override init() {
        super.init()
        locationManager.delegate = self
        requestLocation()
        
    }


    func fetchWeather() async {
        guard let location = locationManager.location else {
            requestLocation()
            return
        }
        
        guard let url = URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid={API key}") else {
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let weatherResponse = try? JSONDecoder().decode(WeatherModel.self, from: data),
               let weatherValue = weatherResponse.data.timelines.first?.intervals.first?.values,
               let weatherCode = WeatherCode(rawValue: "\(weatherValue.weatherCode)") {
                DispatchQueue.main.async { [weak self] in
                    self?.currentWeather = Weather(temperature: Int(weatherValue.temperature),
                                                   weatherCode: weatherCode, startTime: )
                }
            }
        } catch {
            // handle the error
        }
    }
    
    private func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        Task { await fetchWeather() }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // handle the error
    }
}

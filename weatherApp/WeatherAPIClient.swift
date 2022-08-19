//
//  WeatherAPIClient.swift
//  weatherApp
//
//  Created by Ebbyy on 2022/08/14.
//


import Foundation
import CoreLocation

final class WeatherAPIClient: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published private(set) var currentWeather: WeatherEntity?
    @Published private(set) var weatherData: WeatherResponseEntity?
    
    private let locationManager = CLLocationManager()
    private let dateFormatter = ISO8601DateFormatter()
    private let apiKey = "0b4bb5df77b8bc40e48691ac7b7f5e1e"
    
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
        print(location.coordinate.latitude)
        print(location.coordinate.longitude)
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?units=metric&lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(apiKey)"
        ) else {
            fatalError("Missing URL")
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let weatherResponse = try? JSONDecoder().decode(WeatherResponseEntity.self, from: data),
               let weatherValue = weatherResponse.list.first,
               let mainValue = weatherValue.weather.first
            {
                DispatchQueue.main.async { [weak self] in
                    self?.currentWeather = WeatherEntity(id: Int(mainValue.id), main: mainValue.main, description: String(mainValue.description))
                    self?.weatherData = weatherResponse
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

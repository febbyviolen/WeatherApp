//
//  WeatherAPIClient.swift
//  weatherApp
//
//  Created by Ebbyy on 2022/08/14.
//


import Foundation
import CoreLocation

final class WeatherAPIClient: NSObject, ObservableObject, CLLocationManagerDelegate {
   // @Published private(set) var currentWeather: List?
    @Published private(set) var weatherInfoCurrent: WeatherInfoCurrent?
    @Published private(set) var weatherInfoHourly: [WeatherInfoHourly] = []
   // @Published private(set) var cityName: String = ""
    
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
                    self?.weatherInfoCurrent = WeatherInfoCurrent (city: weatherResponse.city.name, dt_txt: weatherValue.dt_txt, temp: weatherValue.main.temp, humidity: weatherValue.main.humidity, pressure: weatherValue.main.pressure, speed: weatherValue.wind.speed,  description: MainDesc(rawValue: "\(mainValue.main)")!, main: mainValue.main)
                    for i in 0...8 {
                        self?.weatherInfoHourly.append(WeatherInfoHourly(dt_txt: weatherResponse.list[i].dt_txt, temp: weatherResponse.list[i].main.temp, description: MainDesc(rawValue: "\(weatherResponse.list[i].weather.first?.main ?? "Clear")")!))
                    }
                    
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

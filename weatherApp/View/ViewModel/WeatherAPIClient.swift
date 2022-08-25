//
//  WeatherAPIClient.swift
//  weatherApp
//
//  Created by Ebbyy on 2022/08/14.
//


import Foundation
import CoreLocation

final class WeatherAPIClient: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published private(set) var weatherInfoCurrent: WeatherInfoCurrent?
    @Published private(set) var weatherInfoHourly: [WeatherInfoHourly] = []
    @Published private(set) var weatherInfoDaily: [WeatherInfoDaily] = []
   
    
    private let locationManager = CLLocationManager()
    private let dateFormatter = ISO8601DateFormatter()
    private let apiKey = "deletedAPIKEY"
    
    override init() {
        super.init()
      //  locationManager.delegate = self
       // requestLocation()
    }
    
    func fetchWeather() async {
        guard let location = locationManager.location else {
            requestLocation()
            
            return
        }
        
        guard let url = URL(string: "https://pro.openweathermap.org/data/2.5/forecast/hourly?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(apiKey)&units=metric"
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
                    self?.weatherInfoCurrent = WeatherInfoCurrent (city: weatherResponse.city.name, dt_txt: weatherValue.dt_txt, temp: weatherValue.main.temp, humidity: weatherValue.main.humidity, feels_like: weatherValue.main.feels_like, speed: weatherValue.wind.speed,  description: MainDesc(rawValue: "\(mainValue.main)")!, main: mainValue.main, country: weatherResponse.city.country)
                    self?.weatherInfoHourly.removeAll()
                    for i in 0...24 {
                        self?.weatherInfoHourly.append(WeatherInfoHourly(dt_txt: weatherResponse.list[i].dt_txt, temp: weatherResponse.list[i].main.temp, description: MainDesc(rawValue: "\(weatherResponse.list[i].weather.first?.main ?? "Clear")")!))
                    }
                    
                }
            }
        } catch {
            // handle the error
        }
        
        guard let url2 = URL(string: "https://pro.openweathermap.org/data/2.5/forecast/daily?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(apiKey)&units=metric"
        ) else {
            fatalError("Missing URL")
        }
        
        do {
            let (data2, _) = try await URLSession.shared.data(from: url2)
            if let weatherResponse2 = try? JSONDecoder().decode(DailyWeatherResponseEntity.self, from: data2)
               
            {
                DispatchQueue.main.async { [weak self] in
                    self?.weatherInfoDaily.removeAll()
                    for i in 0...6 {
                        self?.weatherInfoDaily.append(WeatherInfoDaily(dt: weatherResponse2.list[i].dt, max: weatherResponse2.list[i].temp.max, min: weatherResponse2.list[i].temp.min, description: MainDesc(rawValue: "\(weatherResponse2.list[i].weather.first?.main ?? "Clear")")!))
                    }
                    
                }
            }
        } catch {
            // handle the error
        }
        
        print(location.coordinate.latitude)
        print(location.coordinate.longitude)
        
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

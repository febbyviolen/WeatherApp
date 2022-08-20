//
//  ContentView.swift
//  weatherApp
//
//  Created by Ebbyy on 2022/08/14.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var weatherAPIClient = WeatherAPIClient()
    var body: some View {
        VStack(alignment: .center) {
            if let weatherInfoCurrent = weatherAPIClient.weatherInfoCurrent  {
                let weatherInfoHourly = weatherAPIClient.weatherInfoHourly
                let weatherInfoDaily = weatherAPIClient.weatherInfoDaily
            HStack(alignment: .center, spacing: UIScreen.main.bounds.width*0.7/10) {
                VStack(alignment: .leading, spacing: 10){
                    Text("\(weatherInfoCurrent.city)")
                        .font(.title2)
                        .foregroundColor(Color("Font"))
                    Text("\(Int(weatherInfoCurrent.temp))º")
                        .font(.system(size: 60))
                        .foregroundColor(Color("Font"))
                    Text("\(weatherInfoCurrent.description.desc)")
                        .font(.title2)
                        .foregroundColor(Color("Font"))
                        .frame(alignment: .leading)
                        .padding(3)
                        .padding(.horizontal, 5)
                        .background(.gray.opacity(0.2))
                        .cornerRadius(30)
                }
                .padding(30)

                weatherInfoCurrent.description.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width*0.9/2, height: UIScreen.main.bounds.height*2/10, alignment: .trailing)

                }
                
                Spacer(minLength: 30)
                
                TodaysDetailView(weatherInfoCurrent)
                    .padding(.horizontal)
                    .padding(.horizontal)

                Spacer(minLength: 50)

                HStack{
                    Text("Today")
                        .foregroundColor(Color.gray)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.horizontal)
                
                TodaysTempView(weatherInfoHourly)
                    .padding(.horizontal)
                    .padding(.horizontal)

                Spacer(minLength: 40)

                ThisWeekView(weatherInfoDaily)
                    .padding(.horizontal)
                    .padding(.horizontal, 25)

            }else {
                Text("No weather info available yet.\nTap on refresh to fetch new data.\nMake sure you have enabled location permissions for the app.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                
                Button("Refresh", action: {
                    Task {
                        await weatherAPIClient.fetchWeather()
                    }
                })
            }
        }
        .onAppear {
            Task {
                await weatherAPIClient.fetchWeather()
            }
        }
        
        .background(Color("Background").ignoresSafeArea())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    
    private func TodaysDetailView(_ weather: WeatherInfoCurrent) -> some View {
        HStack(alignment: .center, spacing: 50){
            HStack{
                Image(systemName: "humidity")
                    .font(.title3)
                    .foregroundColor(Color("Font"))
                Text("\(weather.humidity)%")
                    .font(.subheadline)
                    .foregroundColor(Color("Font"))
            }
            HStack{
                Image(systemName: "clock")
                    .font(.title3)
                    .foregroundColor(Color("Font"))
                Text("\(weather.pressure) mBar")
                    .font(.subheadline)
                    .foregroundColor(Color("Font"))
            }
            HStack{
                Image(systemName: "wind")
                    .font(.title3)
                    .foregroundColor(Color("Font"))
                Text("\(weather.speed, specifier: "%.2f")km/h")
                    .font(.subheadline)
                    .foregroundColor(Color("Font"))
            }
        }
    }
    
    private func TodaysTempView(_ weatherInfoHourly: [WeatherInfoHourly]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20){
                ForEach(weatherInfoHourly, id: \.self) { weather in
                    VStack(spacing: 10) {
                        Text("\(getHour(weather.dt_txt))")
                            .foregroundColor(Color("Font"))
                            .font(.subheadline)
                        weather.description.image
                           .resizable()
                           .aspectRatio(contentMode: .fit)
                           .frame(minWidth: 30, maxWidth: 50, minHeight: 30, maxHeight: 50, alignment: .center)
                        Text("\(Int(weather.temp))º")
                           .foregroundColor(Color("Font"))
                           .font(.headline)
                        
                    }
                }
            }
        }
    }
    
    private func getHour(_ hour: String) -> String {
        let split = hour.split(separator: " ")
        let splitt = split[1].split(separator: ":")
        if(Int(splitt[0])! > 12) {
            return "\(String(splitt[0])) PM"
        } else {
            return "\(String(splitt[0])) AM"
        }
    }
    
    private func getDay(_ day: Int) -> String {
        let unixTimestamp = Double(day)
        let date = Date(timeIntervalSince1970: unixTimestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
        
    }

    private func ThisWeekView(_ weatherInfoDaily: [WeatherInfoDaily]) -> some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                ForEach(weatherInfoDaily, id:\.self){ weather in
                    HStack(spacing: 15){
                        Text("\(getDay(weather.dt))")
                            .foregroundColor(Color("Font"))
                        Spacer()
                        weather.description.image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(minWidth: 30, idealWidth: 30, maxWidth: 100, minHeight: 30, idealHeight: 30, maxHeight: 100, alignment: .center)
                        Spacer()
                        Text("\(Int(weather.min))º")
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Font2"))
                        Text("\(Int(weather.max))º")
                            .foregroundColor(Color("Font"))
                    }
                }
            }
        }
    }
    
    
}

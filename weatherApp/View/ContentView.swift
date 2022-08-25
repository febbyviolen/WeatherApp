//
//  ContentView.swift
//  weatherApp
//
//  Created by Ebbyy on 2022/08/14.
//

import SwiftUI
import BottomSheet

struct ContentView: View {
    @StateObject private var weatherAPIClient = WeatherAPIClient()
    @State var bottomSheetPosition: BottomSheetPosition = .middle
    @State var bottomSheetTranslation: CGFloat = BottomSheetPosition.middle.rawValue
    @State var hasDragged: Bool = false
    var bottomSheetTranslationProrated: CGFloat {
        (bottomSheetTranslation - BottomSheetPosition.middle.rawValue)/(BottomSheetPosition.top.rawValue - BottomSheetPosition.middle.rawValue)
    }
    var bottomSheetTranslationProrated2: CGFloat {
        (bottomSheetTranslation - BottomSheetPosition.middle.rawValue)/(BottomSheetPosition.top.rawValue - BottomSheetPosition.middle.rawValue)
    }
    @State var count = 0
    
    var body: some View {
        GeometryReader { geometry in
            let screenHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
            let imageOffset = screenHeight + 36
            
            ZStack {
                VStack(alignment: .center) {
//                    if let weatherInfoCurrent = weatherAPIClient.weatherInfoCurrent {

                    let weatherInfoCurrent = WeatherInfoCurrent(city: "Seoul", dt_txt: "2020-08-05 13:00:00", temp: 30.20, humidity: 30, feels_like: 32.3 , speed: 120.23, description: MainDesc(rawValue: "Clear")!, main: "apoye", country: "South Korea")

                    let weatherInfoHourly : [WeatherInfoHourly] = [(WeatherInfoHourly(dt_txt: "2020-08-05 13:00:00", temp: 10.32, description: MainDesc(rawValue: "Clear")!)),(WeatherInfoHourly(dt_txt: "2020-08-05 13:00:00", temp: 10.32, description: MainDesc(rawValue: "Clear")!)),(WeatherInfoHourly(dt_txt: "2020-08-05 13:00:00", temp: 10.32, description: MainDesc(rawValue: "Clear")!)),(WeatherInfoHourly(dt_txt: "2020-08-05 13:00:00", temp: 10.32, description: MainDesc(rawValue: "Clear")!)),(WeatherInfoHourly(dt_txt: "2020-08-05 13:00:00", temp: 10.32, description: MainDesc(rawValue: "Clear")!)),(WeatherInfoHourly(dt_txt: "2020-08-05 13:00:00", temp: 10.32, description: MainDesc(rawValue: "Clear")!)),(WeatherInfoHourly(dt_txt: "2020-08-05 13:00:00", temp: 10.32, description: MainDesc(rawValue: "Clear")!)),(WeatherInfoHourly(dt_txt: "2020-08-05 13:00:00", temp: 10.32, description: MainDesc(rawValue: "Clear")!)),(WeatherInfoHourly(dt_txt: "2020-08-05 13:00:00", temp: 10.32, description: MainDesc(rawValue: "Clear")!))]
                    
                    let weatherInfoDaily : [WeatherInfoDaily] = [(WeatherInfoDaily(dt: 1568977200, max: 30.30, min: 32.23, description: MainDesc(rawValue: "Clear")!)), (WeatherInfoDaily(dt: 1568977200, max: 30.30, min: 32.23, description: MainDesc(rawValue: "Clear")!)),(WeatherInfoDaily(dt: 1568977200, max: 30.30, min: 32.23, description: MainDesc(rawValue: "Clear")!)),(WeatherInfoDaily(dt: 1568977200, max: 30.30, min: 32.23, description: MainDesc(rawValue: "Clear")!)),(WeatherInfoDaily(dt: 1568977200, max: 30.30, min: 32.23, description: MainDesc(rawValue: "Clear")!)),(WeatherInfoDaily(dt: 1568977200, max: 30.30, min: 32.23, description: MainDesc(rawValue: "Clear")!)),(WeatherInfoDaily(dt: 1568977200, max: 30.30, min: 32.23, description: MainDesc(rawValue: "Clear")!))]
//
//                    let weatherInfoHourly = weatherAPIClient.weatherInfoHourly
//                    let weatherInfoDaily = weatherAPIClient.weatherInfoDaily
                    
                    HStack(alignment: .center, spacing: UIScreen.main.bounds.width*0.7/10) {
                        VStack(alignment: .leading, spacing: 5){
                            Text("\(countryName(from:weatherInfoCurrent.country)),")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                            Text("\(weatherInfoCurrent.city)")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                            Text("\(getDate(weatherInfoCurrent.dt_txt))")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                        }
                        .padding(.horizontal, 40)
                        .padding(.top, 60)
                       
                        Spacer()

                    }
                    .offset(y : -bottomSheetTranslationProrated * imageOffset)
                    
                    hourlyView(weatherInfoHourly)
                        .padding(.vertical)
                        .offset(y : -bottomSheetTranslationProrated * imageOffset)
                    
                    
                    Spacer()
                    BottomSheetView(position: $bottomSheetPosition) {
                        
                    } content: {
                        BottomSlide()
                            .overlay(alignment: .top){
                                VStack(alignment: .center){
                                    currentWeatherBox(bottomSheetTranslationProrated, weatherInfoCurrent)
                                        .padding(.horizontal)
                                        .padding(.horizontal)
                                        .offset(y: -150)
                                        .onTapGesture {
                                            bottomSheetPosition = .middle
                                        }
                                    
                                    HStack {
                                        Text("7 Days Forecast")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .padding(.top)
                                            .padding(.top)
                                            .padding(.horizontal)
                                            .padding(.horizontal)
                                        Spacer()
                                    }.offset(y: -150)
                                    
                                    dailyView(weatherInfoDaily)
                                        .offset(y: -150)
                                    
                                   

                                }.offset(y: hasDragged ? bottomSheetTranslationProrated + 70 : 0)
                            }
                    }
                    .onBottomSheetDrag{ translation in
                        bottomSheetTranslation = translation / screenHeight
                        
                        withAnimation(.linear){
                            if bottomSheetPosition == BottomSheetPosition.top {
                                hasDragged = true
                                
                            } else {
                                hasDragged = false
                            }
                        }
//
//                    }
//
//                    }else {

                    }
                }
//                .onAppear {
//                    Task {
//                        await weatherAPIClient.fetchWeather()
//                        print(count)
//                    }
//                }
                
            }
            .background(LinearGradient(colors: [Color("Bluebox").opacity(0.8), Color("Bluebox")], startPoint: .init(x:0.1, y:0.2), endPoint: .bottomTrailing)).ignoresSafeArea()
                    
        }
    }
}
            

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    private func getHour(_ hour: String) -> String {
        let split = hour.split(separator: " ")
        let splitt = split[1].split(separator: ":")
        if(Int(splitt[0])! > 12) {
            return "\(String(splitt[0])) PM"
        } else {
            return "\(String(splitt[0])) AM"
        }
    }
    
    private func getDate(_ get: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "EEEE, dd MMMM"
        
        if let date = dateFormatterGet.date(from: get) {
            return dateFormatterPrint.string(from: date)
        } else {
            return ".."
        }
    }
    
    private func getDay(_ day: Int) -> String {
        let unixTimestamp = Double(day)
        let date = Date(timeIntervalSince1970: unixTimestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
        
    }
    
    func countryName(from countryCode: String) -> String {
        if let name = (Locale.current).localizedString(forRegionCode: countryCode) {
            return name
        }

        return countryCode
    }

    private func currentWeatherBox(_ point: CGFloat, _ weather: WeatherInfoCurrent) -> some View {
        RoundedRectangle(cornerRadius: 40)
            .fill(LinearGradient(colors: [Color("Bluebox2"), Color("Bluebox")], startPoint: .init(x:0.1, y:0.2), endPoint: .bottom))
            .frame(width: (UIScreen.main.bounds.width * 9/10), height: ((UIScreen.main.bounds.height * 4/10) - ( point * (UIScreen.main.bounds.height * 4/10 - UIScreen.main.bounds.height * (2.5/10)))), alignment: .center)
            .shadow(color: Color("Bluebox").opacity(0.4), radius: 10, x: 0, y: 20)
            .overlay{
                VStack {
                    HStack() {
                        VStack(alignment: .center){
                            HStack{
                                Text("\(weather.description.desc)")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .overlay{
                                        weather.description.image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 230, height: 230)
                                            .offset(x: 40, y: -125)
                                            .shadow(color: Color.white, radius: 50, x: 0, y: 50)
                                    }
                                Spacer()
                            }
                            HStack{
                                Text("\(weather.main)")
                                    .foregroundColor(.white)
                                    Spacer()
                            }
                            Spacer()
                        }
                        .offset(y: 160)
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 5){
                            LinearGradient(colors: [Color.white, Color("FontBlue").opacity(0.9)], startPoint: .top, endPoint: .bottom)
                                .mask(alignment: .leading){
                                    Text("\(Int(weather.temp))º")
                                        .fontWeight(.bold)
                                        .font(.system(size: 80))
                                }
                                .frame(width: 160, height: 90)
                            Text("Feels like \(Int(weather.feels_like))º")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                            Spacer()
                            
                        }
                        .padding(.top)
                    }
                    .padding(.leading, 25)
                    
                    
                    HStack {
                        VStack() {
                            Image("feelsLikeIcon")
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: (UIScreen.main.bounds.width * 9/10) * 1/5, height: (UIScreen.main.bounds.width * 9/10) * 1/5)
                                .background(Color.white.opacity(0.2))
                            .cornerRadius(20)
                            Text("\(Int(weather.feels_like))º")
                                .foregroundColor(.white)
                        }
                        .padding()
                        VStack() {
                            Image("humidityIcon")
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: (UIScreen.main.bounds.width * 9/10) * 1/5, height: (UIScreen.main.bounds.width * 9/10) * 1/5)
                                .background(Color.white.opacity(0.2))
                            .cornerRadius(20)
                            Text("\(weather.humidity)%")
                                .foregroundColor(.white)
                        }
                        .padding()
                        VStack() {
                            Image("windIcon")
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: (UIScreen.main.bounds.width * 9/10) * 1/5, height: (UIScreen.main.bounds.width * 9/10) * 1/5)
                                .background(Color.white.opacity(0.2))
                            .cornerRadius(20)
                            Text("\(Int(weather.speed))km/h")
                                .foregroundColor(.white)
                        }
                        .padding()
                    }
                    .opacity(1 - point)
                }
                
            }
    }
    
    private func hourlyView(_ weather: [WeatherInfoHourly]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20){
                ForEach(weather, id: \.self) { w in
                    RoundedRectangle(cornerRadius: 40)
                        .fill(.white).opacity(0.2)
                        .frame(width: 80, height: 130)
                        .cornerRadius(40)
                        .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 0)
                        .overlay{
                            VStack(spacing: 5) {
                                Text("\(getHour(w.dt_txt))")
                                    .foregroundColor(Color.white)
                                    .fontWeight(.semibold)
                                    .font(.subheadline)
                                w.description.image2
                                   .resizable()
                                   .aspectRatio(contentMode: .fit)
                                   .frame(minWidth: 30, maxWidth: 50, minHeight: 30, maxHeight: 50, alignment: .center)
                                Text("\(Int(w.temp))º")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .font(.title3)
                            }
                    }
                }
                
            }
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
    private func dailyView(_ weather: [WeatherInfoDaily]) -> some View {
        VStack{
            ForEach(weather, id: \.self) { data in
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
                    .frame(height: 60)
                    .overlay(alignment: .center) {
                        HStack(alignment: .center, spacing: 15){
                            Text("\(getDay(data.dt))")
                                .foregroundColor(Color("Font"))
                                .fontWeight(.semibold)
                            Spacer()
                            data.description.image2
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(minWidth: 20, maxWidth: 30, minHeight: 20, maxHeight: 40, alignment: .center)
                            Spacer()
                            Text("\(Int(data.min))º")
                                .fontWeight(.semibold)
                                .foregroundColor(Color("Font2"))
                            Text("\(Int(data.max))º")
                                .foregroundColor(Color("Font"))
                        }
                        .padding(.horizontal)
                    }
                    
                .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 0)
                .padding(.horizontal)
            }
        }
    }
}

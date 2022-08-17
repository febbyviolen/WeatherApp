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
           
            if let currentWeather = weatherAPIClient.currentWeather  {
                HStack(alignment: .center, spacing: UIScreen.main.bounds.width*0.7/10) {
                    VStack(alignment: .leading, spacing: 10){
                        Text("San Fransisco")
                            .font(.title2)
                            .foregroundColor(Color("Font"))
                        Text("\(currentWeather.temperature)º")
                            .font(.system(size: 70))
                            .foregroundColor(Color("Font"))
                        Text("\(currentWeather.weatherCode.rawValue)")
                            .font(.title3)
                            .foregroundColor(Color("Font"))
                            .frame(alignment: .leading)
                            .padding()
                            .padding(.horizontal)
                            .background(.gray.opacity(0.2))
                            .cornerRadius(30)
                            .offset(x: -10)


                    }
                    .padding(30)

                    currentWeather.weatherCode.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width*0.9/2, height: UIScreen.main.bounds.height*2/10, alignment: .trailing)

                    }
                Spacer(minLength: 30)

                HStack(alignment: .center, spacing: 50){
                    HStack{
                        Image(systemName: "humidity")
                            .font(.title3)
                            .foregroundColor(Color("Font"))
                        Text("12%")
                            .font(.subheadline)
                            .foregroundColor(Color("Font"))
                    }
                    HStack{
                        Image(systemName: "clock")
                            .font(.title3)
                            .foregroundColor(Color("Font"))
                        Text("0.533 mBar")
                            .font(.subheadline)
                            .foregroundColor(Color("Font"))
                    }
                    HStack{
                        Image(systemName: "wind")
                            .font(.title3)
                            .foregroundColor(Color("Font"))
                        Text("9km/h")
                            .font(.subheadline)
                            .foregroundColor(Color("Font"))
                    }
                }
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

                ScrollView(.horizontal) {
                    VStack(spacing: 10){
                        Text("10 AM")
                            .foregroundColor(Color("Font"))
                            .font(.subheadline)
                        Image("thnderstorm")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(minWidth: 30, idealWidth: 50, maxWidth: 100, minHeight: 30, idealHeight: 50, maxHeight: 30, alignment: .center)
                        Text("30º")
                            .foregroundColor(Color("Font"))
                            .font(.headline)
                    }

                }
                .padding(.horizontal)
                .padding(.horizontal)

                Spacer(minLength: 20)

                ScrollView(.vertical){
                    HStack(spacing: 15){
                        Text("Monday")
                            .foregroundColor(Color("Font"))
                        Spacer()
                        Image("thnderstorm")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(minWidth: 30, idealWidth: 30, maxWidth: 100, minHeight: 30, idealHeight: 30, maxHeight: 100, alignment: .center)
                        Spacer()
                        Text("30º")
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Font"))
                        Text("35º")
                            .foregroundColor(Color("Font"))
                    }

                    HStack(spacing: 15){
                        Text("Monday")
                            .foregroundColor(Color("Font"))
                        Spacer()
                        Image("thnderstorm")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(minWidth: 30, idealWidth: 30, maxWidth: 100, minHeight: 30, idealHeight: 30, maxHeight: 100, alignment: .center)
                        Spacer()
                        Text("30º")
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Font"))
                        Text("35º")
                            .foregroundColor(Color("Font"))
                    }

                }.padding(.horizontal)
                    .padding()

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

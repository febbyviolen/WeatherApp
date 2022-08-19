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
                CurrentView()
                
                Spacer(minLength: 30)
                
                TodaysDetailView()
                    .padding(.horizontal)
                    .padding(.horizontal)

                Spacer(minLength: 50)

                TodaysTempView()
                    .padding(.horizontal)
                    .padding(.horizontal)

                Spacer(minLength: 20)

                ThisWeekView()
                    .padding(.horizontal)
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

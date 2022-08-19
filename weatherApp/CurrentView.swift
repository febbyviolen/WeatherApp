//
//  CurrentView.swift
//  weatherApp
//
//  Created by Ebbyy on 2022/08/20.
//

import SwiftUI

struct CurrentView: View {
    var body: some View {
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
    }
}

struct CurrentView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentView()
    }
}

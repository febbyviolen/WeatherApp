//
//  TodaysDetailView.swift
//  weatherApp
//
//  Created by Ebbyy on 2022/08/20.
//

import SwiftUI

struct TodaysDetailView: View {
    var body: some View {
        
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
    }
}

struct TodaysDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TodaysDetailView()
    }
}

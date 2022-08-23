//
//  HourlyView.swift
//  weatherApp
//
//  Created by Ebbyy on 2022/08/22.
//

import SwiftUI

struct HourlyView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20){
                RoundedRectangle(cornerRadius: 40)
                    .fill(.white)
                    .frame(width: 80, height: 130)
                    .cornerRadius(40)
                    .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 0)
                    .overlay{
                        VStack(spacing: 5) {
                            Text("10 PM")
                                .foregroundColor(Color.gray)
                                .fontWeight(.semibold)
                                .font(.subheadline)
                            Image("cloudyIcon")
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                               .frame(minWidth: 30, maxWidth: 50, minHeight: 30, maxHeight: 50, alignment: .center)
                            Text("30º")
                                .foregroundColor(.gray)
                                .fontWeight(.bold)
                                .font(.title3)
                        }
                    }
                
            }
            .padding(.horizontal)
        }
        .padding(.horizontal)
        
    }
}

struct HourlyView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyView()
    }
}

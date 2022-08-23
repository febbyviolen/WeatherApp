//
//  DailyView.swift
//  weatherApp
//
//  Created by Ebbyy on 2022/08/23.
//

import SwiftUI

struct DailyView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
                    .frame(width: .infinity, height: 60)
                    .overlay(alignment: .center) {
                        HStack(alignment: .center, spacing: 15){
                            Text("Monday")
                                .foregroundColor(Color.blue)
                                .fontWeight(.semibold)
                            Spacer()
                            Image("sunnyIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(minWidth: 20, maxWidth: 30, minHeight: 20, maxHeight: 40, alignment: .center)
                            Spacer()
                            Text("30º")
                                .fontWeight(.semibold)
                                .foregroundColor(Color("Font2"))
                            Text("32º")
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

struct DailyView_Previews: PreviewProvider {
    static var previews: some View {
        DailyView()
    }
}

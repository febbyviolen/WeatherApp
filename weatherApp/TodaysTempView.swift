//
//  TodaysTempView.swift
//  weatherApp
//
//  Created by Ebbyy on 2022/08/20.
//

import SwiftUI

struct TodaysTempView: View {
    var body: some View {
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
    }
}

struct TodaysTempView_Previews: PreviewProvider {
    static var previews: some View {
        TodaysTempView()
    }
}

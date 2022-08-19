//
//  ThisWeekView.swift
//  weatherApp
//
//  Created by Ebbyy on 2022/08/20.
//

import SwiftUI

struct ThisWeekView: View {
    var body: some View {
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

        }
    }
}

struct ThisWeekView_Previews: PreviewProvider {
    static var previews: some View {
        ThisWeekView()
    }
}

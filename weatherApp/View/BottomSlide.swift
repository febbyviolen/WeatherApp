//
//  HourlyView.swift
//  weatherApp
//
//  Created by Ebbyy on 2022/08/21.
//

import SwiftUI

struct BottomSlide: View {
    var body: some View {
        ScrollView{
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 44))
        .frame(maxHeight: .infinity)
    }
}

struct BottomSlide_preview: PreviewProvider {
    static var previews: some View {
        BottomSlide()
    }
}

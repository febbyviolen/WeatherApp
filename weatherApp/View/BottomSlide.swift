//
//  HourlyView.swift
//  weatherApp
//
//  Created by Ebbyy on 2022/08/21.
//

import SwiftUI

struct BottomSlide: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 44)
            .fill(.white)
            .ignoresSafeArea(edges: .bottom)
    }
}

struct BottomSlide_preview: PreviewProvider {
    static var previews: some View {
        BottomSlide()
    }
}

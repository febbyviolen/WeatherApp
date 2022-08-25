//
//  Main.swift
//  weatherApp
//
//  Created by Ebbyy on 2022/08/16.
//

import SwiftUI

struct Main: View {
    var body: some View {
        TabView{
            ContentView()
                .tabItem{
                    Image(systemName: "house")
                        .padding()
                }
            
            FavoriteView()
                .tabItem{
                    Image(systemName: "heart")
                }
        }
        
       
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}

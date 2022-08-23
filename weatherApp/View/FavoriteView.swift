//
//  FavoriteView.swift
//  weatherApp
//
//  Created by Ebbyy on 2022/08/16.
//

import SwiftUI

struct FavoriteView: View {
    @State var searchQuery = ""
    @State private var isEditing = false
    @State var todoItems = ["asdfasdfasdf", "fadsasdfasdf", "asdfasgwefervg"]
    var body: some View {
        VStack{
            HStack{
                TextField("Search ...", text: $searchQuery)
                   .padding(20)
                   .padding(.horizontal, 30)
                   .background(Color("Background"))
                   .cornerRadius(15)
                   .overlay(
                       HStack {
                           Image(systemName: "magnifyingglass")
                               .animation(.easeIn)
                               .foregroundColor(isEditing ? Color("Font") : Color.gray)
                               .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                               .padding(.leading)
                    
                           if isEditing {
                               Button(action: {
                                   self.searchQuery = ""
                               }) {
                                   Image(systemName: "multiply.circle.fill")
                                       .foregroundColor(.gray)
                                       .padding(.trailing, 8)
                               }
                           }
                       }
                   )
                   .onTapGesture {
                       self.isEditing.toggle()
                   }
                
                Image(systemName: "pencil")
                    .padding(.trailing)
                    
            }
            .padding()
            
//            List(todoItems.filter({ searchQuery.isEmpty ? true : $0.name.contains(searchQuery)})) { item in
//                Text(item)
//            }
            HStack{
                Spacer()
                FavBox_()
                Spacer()
                FavBox_()
                Spacer()
            }
            Spacer()
            
        }
        .padding(.vertical)
        .background(Color("Background").ignoresSafeArea())
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}

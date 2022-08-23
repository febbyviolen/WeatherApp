//
//  FavBox .swift
//  weatherApp
//
//  Created by Ebbyy on 2022/08/16.
//

import SwiftUI

struct FavBox_: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            HStack(spacing: 50){
                Text("30º")
                    .font(.title3)
                    .foregroundColor(Color("Font"))
                Image("rainy")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width*0.5/3, height: UIScreen.main.bounds.height*1/16, alignment: .trailing)
            }
            Text("San Fransisco")
                .font(.title3)
                .foregroundColor(Color("Font"))
            Text("USA")
                .font(.subheadline)
                .foregroundColor(Color("Font"))
            
            HStack{
                HStack{
                    Image(systemName: "humidity")
                        .font(.title3)
                        .foregroundColor(Color("Font"))
                    Text("12%")
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
        .padding()
        .frame(width: UIScreen.main.bounds.width*1.3/3, height: UIScreen.main.bounds.height*1/6)
        .padding(.vertical)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(color: Color.gray.opacity(0.2), radius:20, x: 0, y: 0)
        
    }
}

struct FavBox__Previews: PreviewProvider {
    static var previews: some View {
        FavBox_()
    }
}

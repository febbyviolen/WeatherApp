////
////  Dummy.swift
////  weatherApp
////
////  Created by Ebbyy on 2022/08/21.
////
//
//import SwiftUI
//import BottomSheet
//
//struct Dummy: View {
//    @State var bottomSheetPosition: BottomSheetPosition = .middle
//    @State var bottomSheetTranslation: CGFloat = BottomSheetPosition.middle.rawValue
//    @State var hasDragged: Bool = false
//    var bottomSheetTranslationProrated: CGFloat {
//        (bottomSheetTranslation - BottomSheetPosition.middle.rawValue)/(BottomSheetPosition.top.rawValue - BottomSheetPosition.middle.rawValue)
//    }
//    var bottomSheetTranslationProrated2: CGFloat {
//        (bottomSheetTranslation - BottomSheetPosition.middle.rawValue)/(BottomSheetPosition.top.rawValue - BottomSheetPosition.middle.rawValue) + 0.6
//    }
//
//    var body: some View {
//        GeometryReader { geometry in
//            let screenHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
//            let imageOffset = screenHeight + 36
//
//            ZStack {
//                VStack(alignment: .center) {
//                    HStack(alignment: .center, spacing: UIScreen.main.bounds.width*0.7/10) {
//                        VStack(alignment: .leading, spacing: 5){
//                            Text("INDONESIA,")
//                                .font(.title)
//                                .fontWeight(.bold)
//                                .foregroundColor(Color("Font"))
//                            Text("Palembang")
//                                .font(.title)
//                                .fontWeight(.semibold)
//                                .foregroundColor(Color("Font"))
//                            Text("21 August 2022")
//                                .font(.caption)
//                                .fontWeight(.semibold)
//                                .foregroundColor(Color("Font").opacity(0.5))
//                        }
//                        .padding(30)
//                        .offset(y : -bottomSheetTranslationProrated * imageOffset)
//
//                        Spacer()
//
//                        }
//                    Spacer()
//                }
//
//                BottomSheetView(position: $bottomSheetPosition) {
//
//                } content: {
//                    BottomSlide()
//                        .overlay(alignment: .top){
//                            VStack(alignment: .leading){
//                                currentWeatherBox(bottomSheetTranslationProrated)
//                                    .padding(.horizontal)
//                                    .padding(.horizontal)
//                                Text("Today")
//                                    .font(.title2)
//                                    .fontWeight(.bold)
//                                    .padding(.top)
//                                    .padding(.top)
//                                    .padding(.horizontal, 25)
//                                    .padding(.horizontal)
//
//                                HourlyView()
//                                    .padding(.horizontal, 5)
//
//                                Spacer()
//
//                                Text("7 Days Forecast")
//                                    .font(.title2)
//                                    .fontWeight(.bold)
//                                    .padding(.top)
//                                    .padding(.top)
//                                    .padding(.horizontal, 25)
//                                    .padding(.horizontal)
//
//                                DailyView()
//                                    .padding(.leading)
//
//
//
//                            }.offset(y:  bottomSheetTranslationProrated2 * -60)
//                        }
//
//                }
//                .onBottomSheetDrag{ translation in
//                    bottomSheetTranslation = translation / screenHeight
//
//                    withAnimation(.linear){
//                        if bottomSheetPosition == BottomSheetPosition.top {
//                            hasDragged = true
//                        } else {
//                            hasDragged = false
//                        }
//                    }
//
//                }
//            }
//        }
//    }
//}
//
//struct Dummy_Previews: PreviewProvider {
//    static var previews: some View {
//        Dummy()
//    }
//}
//
//extension Dummy{
//    private func TodaysTempView() -> some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 20){
//                VStack(spacing: 10) {
//                    Text("10PM")
//                        .foregroundColor(Color("Font"))
//                        .font(.subheadline)
//                    Image("cloudyIcon")
//                       .resizable()
//                       .aspectRatio(contentMode: .fit)
//                       .frame(minWidth: 30, maxWidth: 50, minHeight: 30, maxHeight: 50, alignment: .center)
//                    Text("30º")
//                       .foregroundColor(Color("Font"))
//                       .font(.headline)
//
//                }
//            }
//        }
//    }
//
//    private func getHour(_ hour: String) -> String {
//        let split = hour.split(separator: " ")
//        let splitt = split[1].split(separator: ":")
//        if(Int(splitt[0])! > 12) {
//            return "\(String(splitt[0])) PM"
//        } else {
//            return "\(String(splitt[0])) AM"
//        }
//    }
//
//    private func getDay(_ day: Int) -> String {
//        let unixTimestamp = Double(day)
//        let date = Date(timeIntervalSince1970: unixTimestamp)
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "EEEE"
//        return dateFormatter.string(from: date)
//
//    }
//
//    private func ThisWeekView() -> some View {
//        ScrollView(.vertical, showsIndicators: false){
//            VStack{
//                HStack(spacing: 15){
//                    Text("MONDAY")
//                        .foregroundColor(Color("Font"))
//                    Spacer()
//                    Image("sunnyIcon")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(minWidth: 30, idealWidth: 30, maxWidth: 100, minHeight: 30, idealHeight: 30, maxHeight: 100, alignment: .center)
//                    Spacer()
//                    Text("30º")
//                        .fontWeight(.semibold)
//                        .foregroundColor(Color("Font2"))
//                    Text("32º")
//                        .foregroundColor(Color("Font"))
//                }
//            }
//        }
//    }
//
//    private func currentWeatherBox(_ point: CGFloat) -> some View {
//        RoundedRectangle(cornerRadius: 40)
//            .fill(LinearGradient(colors: [Color("Bluebox").opacity(0.7), Color("Bluebox")], startPoint: .init(x:0.1, y:0.2), endPoint: .bottom))
//            .frame(width: (UIScreen.main.bounds.width * 9/10), height: ((UIScreen.main.bounds.height * 4/10) - ( point * (UIScreen.main.bounds.height * 4/10 - UIScreen.main.bounds.height * (2.5/10)))), alignment: .center)
//            .shadow(color: Color("Bluebox").opacity(0.4), radius: 10, x: 0, y: 20)
//            .overlay{
//                VStack {
//                    HStack() {
//                        VStack(alignment: .leading){
//                            Text("Sunny")
//                                .font(.title)
//                                .fontWeight(.bold)
//                                .foregroundColor(.white)
//                                .overlay{
//                                    Image("drizzle")
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 230, height: 230)
//                                        .offset(x: 40, y: -125)
//                                        .shadow(color: Color.white, radius: 50, x: 0, y: 50)
//                                }
//                            Text("Sun bright like a diamond")
//                                .foregroundColor(.white)
//                            Spacer()
//                        }
//                        .offset(y: 160)
//
//                        VStack(alignment: .leading, spacing: 5){
//                            LinearGradient(colors: [Color.white, Color("FontBlue").opacity(0.9)], startPoint: .top, endPoint: .bottom)
//                                .mask(alignment: .leading){
//                                    Text("30º")
//                                        .fontWeight(.bold)
//                                        .font(.system(size: 80))
//                                }
//                                .frame(width: 160, height: 90)
//                            Text("Feels like 32º")
//                                .foregroundColor(.white)
//                                .fontWeight(.semibold)
//                            Spacer()
//
//                        }
//                        .padding(.top)
//                    }
//                    .padding(.leading)
//
//
//                    HStack {
//                        VStack() {
//                            Image("feelsLikeIcon")
//                                .resizable()
//                                .scaledToFit()
//                                .padding()
//                                .frame(width: (UIScreen.main.bounds.width * 9/10) * 1/5, height: (UIScreen.main.bounds.width * 9/10) * 1/5)
//                                .background(Color.white.opacity(0.2))
//                            .cornerRadius(20)
//                            Text("32º")
//                                .foregroundColor(.white)
//                        }
//                        .padding()
//                        VStack() {
//                            Image("humidityIcon")
//                                .resizable()
//                                .scaledToFit()
//                                .padding()
//                                .frame(width: (UIScreen.main.bounds.width * 9/10) * 1/5, height: (UIScreen.main.bounds.width * 9/10) * 1/5)
//                                .background(Color.white.opacity(0.2))
//                            .cornerRadius(20)
//                            Text("32º")
//                                .foregroundColor(.white)
//                        }
//                        .padding()
//                        VStack() {
//                            Image("windIcon")
//                                .resizable()
//                                .scaledToFit()
//                                .padding()
//                                .frame(width: (UIScreen.main.bounds.width * 9/10) * 1/5, height: (UIScreen.main.bounds.width * 9/10) * 1/5)
//                                .background(Color.white.opacity(0.2))
//                            .cornerRadius(20)
//                            Text("32º")
//                                .foregroundColor(.white)
//                        }
//                        .padding()
//                    }
//                    .opacity(1 - point)
//                }
//
//            }
//    }
//}

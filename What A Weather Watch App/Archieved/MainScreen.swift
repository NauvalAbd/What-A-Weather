////
////  SplashScreenView.swift
////  What A Weather Watch App
////
////  Created by Nauval Abd on 18/05/24.
////
//
//import SwiftUI
//import CoreLocation
//import WeatherKit
//
//struct SplashScreenView: View {
//    var locationManager = LocationManager()
//    var weatherServiceHelper = WeatherData.shared
//
//    @State var isLoading = true
//    @State var currentLocation: CLLocation?
//    
//    
//
//    @State var stateText: String = "Loading.."
//
//    @State var currentWeather: CurrentWeather?
//    
//    var body: some View {
//        ZStack{
//            LinearGradient(gradient: Gradient(colors: [Color.wawCyanLight, Color.wawCyanDark]), startPoint: .top, endPoint: .bottom)
//                .ignoresSafeArea()
//            if isLoading {
//              ProgressView()
//            }
//            
////            if let location = locationManager.location {
////                Text("Location found")dccccccccccccccccdd//                Text("\(location.latitude)")
////            } else {
////                Text("location not found")
////            }
//            
//            // Your content goes here
//            if let current = currentWeather, !isLoading {
//                
//                VStack {
//                    Text("Tangerang")
//                        .font(.custom("Quicksand Bold", size: 13))
//                        .foregroundColor(.wawOrangeDark)
//                        .padding(.top, -45)
//                   
//                    //                    let tUnit = current.temperature.unit.symbol
//                    //                    Text("\(Int(current.temperature.value))°")
//                    Text("17°")
//                        .font(.custom("Groovy Dream", size: 125))
//                        .foregroundColor(.wawOrangeLight)
//                        .padding(.leading,45)
//                        .padding(.top, -35)
//                    
//                    Text("Partly Cloudy")
//                        .font(.custom("Quicksand Bold", size: 13))
//                        .foregroundColor(.wawOrangeDark)
//                        .padding(.top, -50)
//                }
//            } else {
//                Text(stateText)
//            }
//            
////            Circle()
//////                .trim(from: 0.5, to: 1)
////                .stroke(.wawBlack25, style: StrokeStyle(lineWidth: CGFloat(24), lineCap: .round, lineJoin: .round))
////                .frame(width: 174, height: 174)
////                .ignoresSafeArea()
////                .padding(EdgeInsets())
////                .offset(CGSize(width: 0, height: 140.0))
////            
//            HStack {
//                Text("UVI")
//                    .font(.custom("LilitaOne", size: 12))
//                    .foregroundColor(.wawPurpleOff)
//                    .padding(.top, 175)
//                if let current = currentWeather, !isLoading {
//                    
//                    Text("\(current.uvIndex.value)")
//                        .font(.custom("Groovy Dream", size: 42))
//                        .foregroundColor(.wawPurple)
//                        .padding(.top, 175)
//                }
//                
//                Text("low")
//                    .font(.custom("LilitaOne", size: 14))
//                    .foregroundColor(.wawPurpleOff)
//                
//                    .padding(.top, 175)
//                
//                
//                
//                
//            }
//            ZStack {
//                //                Circle()
//                //                    .foregroundColor(.wawPurpleOff)
//                //                    .frame(width: 40, height: 40)
//                //                    .padding(.top, 75)
//                //                    .padding(.leading,190)
//                //
//                //                Circle()
//                //                    .foregroundColor(.wawGreyLight)
//                //                    .frame(width: 15, height: 15)
//                //                    .padding(.top, 75)
//                //                    .padding(.leading,155)
//                //               Circle()
//                //                   .foregroundColor(.wawGreyLight)
//                //                   .frame(width: 15, height: 15)
//                //                   .padding(.top, 80)
//                //                   .padding(.leading,130)
//                //               Ellipse()
//                //                   .foregroundColor(.wawGreyLight)
//                //                   .frame(width: 35, height: 15)
//                //                   .padding(.top, 90)
//                //                   .padding(.leading,145)
//                Image("Cloud")
//                    .padding(.leading, 183)
//                    .padding(.top, 50)
//                
//            }
//            
//        }
////        .onAppear(perform: {
////            locationManager.updateLocation { location, error in
////                print(location)
////            }
////        })
//        .task {
//            isLoading = true
//            self.locationManager.updateLocation(handler: locationUpdated)
//        }
//        
//        
//        
//    }
//    
//    func locationUpdated(location: CLLocation?, error: Error?) {
//      if let currentLocation: CLLocation = location, error == nil {
//        Task.detached {
//          isLoading = false
//          currentWeather = await weatherServiceHelper.currentWeather(for: currentLocation)
//          stateText = ""
//        }
//      } else {
//        stateText = "Cannot get your location. \n \(error?.localizedDescription ?? "")"
//        isLoading = false
//      }
//    }
//    
//    
//    
////    struct ContentView: View {
////        let imageName = "Cloud" // Ganti dengan nama gambar Anda
////        let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
////        
////        @State private var offset: CGFloat = 0
////        
////        var body: some View {
////            GeometryReader { geometry in
////                Image(imageName)
////                    .resizable()
////                    .scaledToFit()
////                    .frame(width: geometry.size.width, height: geometry.size.height)
////                    .offset(x: offset)
////                    .animation(Animation.linear.repeatForever(autoreverses: false))
////                    .onReceive(timer) { _ in
////                        withAnimation {
////                            offset -= 10 // Atur sesuai kecepatan geser yang diinginkan
////                        }
////                    }
////            }
////            .edgesIgnoringSafeArea(.all)
////        }
////    }
////    
////    struct ContentView_Previews: PreviewProvider {
////        static var previews: some View {
////            ContentView()
////        }
////    }
//    
//}
//  
//#Preview {
//    SplashScreenView()
//}
//

//
//  MainScreenView_New.swift
//  What A Weather Watch App
//
//  Created by Nauval Abd on 22/05/24.
//

import SwiftUI
import WeatherKit
import CoreLocation


struct RadialLayout: Layout {
    var radius: CGFloat
    var angle: Double
    @Binding var offset: Double
    
    
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxWidth = subviews.map { $0.sizeThatFits(.unspecified).width }.max() ?? 0
        let maxHeight = subviews.map { $0.sizeThatFits(.unspecified).height }.max() ?? 0
        let diameter = 2 * radius + max(maxWidth, maxHeight)
        return CGSize(width: diameter, height: diameter)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        for (index, subview) in subviews.enumerated() {
            var point = CGPoint(x: 0, y: -radius)
                .applying(CGAffineTransform(rotationAngle: angle * Double(index) + offset))
            
            point.x += bounds.midX
            point.y += bounds.midY
            
            subview.place(at: point, anchor: .center, proposal: .unspecified)
        }
    }
}

struct MainScreenView_New: View {
    @State private var dragAmount = CGSize.zero
    @State private var offset = 0.0
    @State private var initialOffset = 0.0
    
    @State var attribution: WeatherAttribution?
    @State var modalFlag = false
    @State var isLoading = true
    @State var currentLocation: CLLocation?
    
    @State var stateText: String = "Loading.."
    
    @State var currentWeather: CurrentWeather?
    
    @ObservedObject var locationManager = LocationManager()
    var weatherServiceHelper = WeatherData.shared
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.wawCyanLight, Color.wawCyanDark]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all)
            
            ZStack {
                
                Image("PinClockOrange")
                    .padding(.bottom, 130)
                    .padding(.leading, -105)
                    .rotationEffect(.degrees(13.0))
                    .scaleEffect(CGSize(width: 1.1, height: 1.1))
                
                // Add a circular path as the background
                Circle()
                    .stroke(Color.wawBlack20, lineWidth: 45)
                    .frame(width: 2 * 98, height: 2 * 98) // Diameter is 2 * radius
                
                
                RadialLayout(radius: 98, angle: .pi / 6, offset: $offset) {
                    ForEach(0..<12) { index in
                        ZStack {
                            Circle()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.wawTransparant)
                            Text("\(index + 1)")
                                .foregroundColor(.wawWhite50)
                                .font(.custom("LilitaOne", size: 19))
                        }
                    }
                }
                .frame(width: 300, height: 300)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            // Calculate the temporary offset during the drag
                            let tempOffset = Double(value.translation.width / 100)
                            // Update the offset with the temporary offset
                            self.offset = self.initialOffset + tempOffset
                            print("INI ONCHANGE \(offset)")
                        }
                        .onEnded { value in
                            // When the drag ends, update the initial offset
                            let tempOffset = Double(value.translation.width / 100)
                            self.initialOffset += tempOffset
                            // Set the current drag amount to zero for the next drag
                            self.dragAmount = .zero
                            print("INI ONENDED \(offset)")
                        }
                )
            }
            .frame(width: 300, height: 300)
            .ignoresSafeArea()
            .padding(EdgeInsets())
            .offset(CGSize(width: 0, height: 132.0))
            
            //            Circle()
            //            ////                .trim(from: 0.5, to: 1)
            //                .stroke(.wawBlack20, style: StrokeStyle(lineWidth: CGFloat(35), lineCap: .round, lineJoin: .round))
            //                .frame(width: 174, height: 174)
            //                .ignoresSafeArea()
            //                .padding(EdgeInsets())
            //                .offset(CGSize(width: 0, height: 140.0))
            
            
            VStack {
                
                
                HStack{
                    VStack {
                        if let current = currentWeather {
                            
                            // current condition
                        Text("\(current.condition.description)")
                            .font(.custom("LilitaOne", size: 16))
//                            .frame(width: 100, height: 30)
                            .foregroundColor(.wawOrangeDark)
                            .padding(.trailing, 30)
                
                        //                        .padding(.top, -70)
                        //                        .padding(.leading, -70)
                        
                       //temperature
                            Text("\(Int(current.temperature.value))°")
                                .font(.custom("Groovy Dream", size: 110))
                                .foregroundColor(.wawOrangeLight)
                        }
                        
                        //                        .padding(.top, -55)
                        //                        .padding(.leading,-50)
                        
                    }
                    .padding(.top, 45)
                    .padding(.leading)
                    VStack {
                        
                        // uv
                        Image ("UVsunOrange")
                            .offset(y: 33)
//                            .padding(.top, -13)
                        //                        .padding(.top, -50)
                        //                        .padding(.leading, 55)
                        if let current = currentWeather {
                            if current.uvIndex.category.rawValue == "Moderate" {
                                Text("\(current.uvIndex.value) Mod")
                                    .font(.custom("LilitaOne", size: 15))
                                    .foregroundColor(.wawOrangeDark)
                                    .offset(y: 14)
                                    .padding(.top, 14)
                                
                            } else {
                                Text("\(current.uvIndex.value)")
                                    .font(.custom("LilitaOne", size: 15))
                                    .foregroundColor(.wawOrangeDark)
                                    .offset(y: 14)
                                    .padding(.top, 14)
                                
                        
                        // icon umbrella
                        Image ("UmbrellaOrange")
                            .padding(.top, 10)
                        //                        .padding(.leading, 55)
                        // possibility rain
                                Text("\(Int(current.precipitationIntensity.value))%")
                            .font(.custom("LilitaOne", size: 15))
                            .foregroundColor(.wawOrangeDark)
                            .offset(y: -10)
                        //                        .padding(.top, -70)
                        //                        .padding(.leading, 60)
                        //
                        
                        
                        
                            }
                            
                            
                        }
                        //                        .padding(.top, -30)
                        //                        .padding(.leading,50)
                        
                        
                                                   
                    }.padding(.top, 30)
                        .ignoresSafeArea()
                }.frame(width: 200, height:150, alignment: .top)
                Spacer()
                
                Text("\(String(describing: locationManager.locationString ?? "_"))")
                    .font(
                        Font.custom("Quicksand", size: 14)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.72, green: 0.38, blue: 0.29))
                
                    .frame(width: 90, alignment: .center)
                    .padding(.bottom, -10)
                
                Spacer()
                
            }
            
            
            //                Text("South Tangerang")
            //                    .font(.custom("Quicksand Bold", size: 15))
            //                    .padding(.top, 175)
            //                    .foregroundColor(.wawOrangeDark)
            //                    .frame(width: 180, height: 100, alignment: .center)
            //                    .multilineTextAlignment(.center)
            
            
            
            
            
            
        }
        .task {
            self.locationManager.updateLocation(handler: locationUpdated)
        }
        .onChange(of: locationManager.locationString) { _, _ in
            //            print(newValue)
            // Lakukan operasi location update disini
            
            if locationManager.location != nil{
                DispatchQueue.main.async { [self] in
                    self.isLoading = false
                }
                print (locationManager.location)
                Task.detached {
                    if let currentLocation = await locationManager.location {
                        let weatherData = await weatherServiceHelper.currentWeather(for: CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude))
                        let attributionData = await weatherServiceHelper.weatherAttribution()
                        
                        DispatchQueue.main.async { [self] in
                            self.currentWeather = weatherData
                            self.attribution = attributionData
                            self.stateText = ""
                        }
                    }
                }
            } else {
                DispatchQueue.main.async { [self] in
                    self.stateText = "Cannot get your location."
                    self.isLoading = false
                }
            }
        }
        .ignoresSafeArea(.all)
    }
    
    func locationUpdated(location: CLLocation?, error: Error?) {
        
    }
}


#Preview {
    MainScreenView_New()
}

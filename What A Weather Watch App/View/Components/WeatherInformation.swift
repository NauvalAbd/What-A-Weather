//
//  WeatherInformation.swift
//  What A Weather Watch App
//
//  Created by mac.bernanda on 27/05/24.
//

import SwiftUI
import WeatherKit

struct WeatherDataView: View {
    @Binding var weatherData : CurrentWeather?
    @Binding var locationString : String?
    
    func foregroundColors(forTemperature temperature: Double) -> (dark: Color, light: Color) {
        switch temperature {
        case ...26:
            return (Color.wawGreenDark, Color.wawGreenLight)
        case 27...28:
            return (Color.wawPurpleDark, Color.wawPurple)
        case 29...30:
            return (Color.wawYellowDark, Color.wawYellowLight)
        case 31...33:
            return (Color.wawPeachDark, Color.wawPeachLight)
        case 34...99:
            return (Color.wawGreyDark, Color.wawGreyLight)
        default:
            return (Color.wawCyanDark, Color.wawCyanLight)
        }
    }
    
    var body: some View {
        if let currWeather = weatherData {
            let fore = foregroundColors(forTemperature: currWeather.temperature.value)
            let conditionDescription = currWeather.condition.description
            let temperatureValue = currWeather.temperature.value
            let uvIndex = currWeather.uvIndex
            let precipitationIntensity = currWeather.precipitationIntensity
            
            VStack {
                HStack{
                    VStack {
                        Text("\(conditionDescription)")
                            .font(.custom("LilitaOne", size: 16))
                            .foregroundColor(fore.dark)
                            .padding(.trailing, 30)
                        
                        Text("\(Int(temperatureValue))°")
                            .font(.custom("Groovy Dream", size: 110))
                            .foregroundColor(fore.light)
                    }
                    .padding(.top, 45)
                    .padding(.leading)
                    
                    VStack {
                        Image ("UVsunOrange")
                            .offset(y: 33)
                        
                        if uvIndex.category.rawValue == "Moderate" {
                            Text("\(uvIndex.value) Mod")
                                .font(.custom("LilitaOne", size: 15))
                                .foregroundColor(fore.dark)
                                .offset(y: 14)
                                .padding(.top, 14)
                            
                        } else {
                            Text("\(uvIndex.value)")
                                .font(.custom("LilitaOne", size: 15))
                                .foregroundColor(fore.dark)
                                .offset(y: 14)
                                .padding(.top, 14)
                            
                            Image ("UmbrellaOrange")
                                .padding(.top, 10)
                            
                            Text("\(precipitationIntensity)%")
                                .font(.custom("LilitaOne", size: 15))
                                .foregroundColor(fore.dark)
                                .offset(y: -10)
                            
                            
                        }
                        
                    }.padding(.top, 30)
                        .ignoresSafeArea()
                }.frame(width: 200, height:150, alignment: .top)
                Spacer()
                
                Text("\(String(describing: locationString ?? "_"))")
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
            .task {
                print("Curr : ", currWeather)
            }
        }
        

        
    }
}

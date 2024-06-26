//
//  WeatherInformation.swift
//  What A Weather Watch App
//
//  Created by mac.bernanda on 27/05/24.
//

import SwiftUI
import WeatherKit

struct WeatherDataView: View {
    @Binding var locationString : String?
    @Binding var conditionDescription : WeatherCondition
    @Binding var temperatureValue : Double
    @Binding var uvIndexValue : Int
    @Binding var uvIndexCat : UVIndex.ExposureCategory
    @Binding var precipitationIntensity : Double
    
    func foregroundColors(forTemperature temperature: Double, forCondition condition: WeatherCondition) -> (dark: Color, light: Color) {
        if rainConditions.contains([conditionDescription]) {
            return (Color.wawGreyDarker, Color.wawGreyDark)
        }
        
        switch temperature {
        case ...26:
            return (Color.wawGreenDark, Color.wawGreenLight)
        case 27...28:
            return (Color.wawPurpleDark, Color.wawPurple)
        case 29...30:
            return (Color.wawYellowDark, Color.wawYellowLight)
        case 31...33:
            return (Color.wawPeachDark, Color.wawPeachLight)
        case 34...:
            return (Color.wawGreyDarker, Color.wawGreyDark)
        default:
            return (Color.wawGreenDark, Color.wawGreenLight)
        }
    }
    
    func iconColor(forTemperature temperature: Double, forCondition condition: WeatherCondition) -> (uv: String, umbrella: String) {
        if rainConditions.contains([conditionDescription]) {
            return ("UVsunGreen", "UmbrellaGreen")
        }
        
        switch temperature {
        case ...26:
            return ("UVsunGreen", "UmbrellaGreen")
        case 27...28:
            return ("UVsunPurple", "UmbrellaPurple")
        case 29...30:
            return ("UVsunYellow", "UmbrellaYellow")
        case 31...33:
            return ("UVsunPeach", "UmbrellaGreen")
        case 34...:
            return ("UVsunGrey", "UmbrellaGrey")
        default:
            return ("UVsunGreen", "UmbrellaGreen")
        }
    }
    
    var body: some View {
        let fore =  foregroundColors(forTemperature: temperatureValue, forCondition: conditionDescription)
        let icon = iconColor(forTemperature: temperatureValue, forCondition: conditionDescription)
        
        VStack {
            HStack{
                VStack {
                    Text("\(conditionDescription.description)")
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
                    Image (icon.uv)
                        .offset(y: 33)
                    
                    if uvIndexCat.rawValue == "Moderate" {
                        Text("\(uvIndexValue) Mod")
                            .font(.custom("LilitaOne", size: 15))
                            .foregroundColor(fore.dark)
                            .offset(y: 14)
                            .padding(.top, 14)
                        
                    } else {
                        Text("\(uvIndexValue)")
                            .font(.custom("LilitaOne", size: 15))
                            .foregroundColor(fore.dark)
                            .offset(y: 14)
                            .padding(.top, 14)
                        
                        Image (icon.umbrella)
                            .padding(.top, 10)
                        
                        Text("\(Int(precipitationIntensity))%")
                            .font(.custom("LilitaOne", size: 15))
                            .foregroundColor(fore.dark)
                            .offset(y: -10)
                    }
                    
                }
                .padding(.top, 30)
                .ignoresSafeArea()
                
            }.frame(width: 200, height:150, alignment: .top)
            Spacer()
            
            Text("\(String(describing: locationString ?? "-"))")
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
    }
}

let rainConditions: [WeatherCondition] = [.rain, .blizzard, .thunderstorms, .drizzle, .freezingRain, .heavyRain]


//
//struct WeatherDataView: View {
//    @Binding var weatherData : CurrentWeather?
//    @Binding var locationString : String?
//
//    func foregroundColors(forTemperature temperature: Double) -> (dark: Color, light: Color) {
//        switch temperature {
//        case ...26:
//            return (Color.wawGreenDark, Color.wawGreenLight)
//        case 27...28:
//            return (Color.wawPurpleDark, Color.wawPurple)
//        case 29...30:
//            return (Color.wawYellowDark, Color.wawYellowLight)
//        case 31...33:
//            return (Color.wawPeachDark, Color.wawPeachLight)
//        case 34...99:
//            return (Color.wawGreyDark, Color.wawGreyLight)
//        default:
//            return (Color.wawCyanDark, Color.wawCyanLight)
//        }
//    }
//
//    var body: some View {
//        if let currWeather = weatherData {
//            let fore = foregroundColors(forTemperature: currWeather.temperature.value)
//            let conditionDescription = currWeather.condition.description
//            let temperature = currWeather.temperature
//            let uvIndex = currWeather.uvIndex
//            let precipitationIntensity = currWeather.precipitationIntensity
//
//            VStack {
//                HStack{
//                    VStack {
//                        Text("\(conditionDescription)")
//                            .font(.custom("LilitaOne", size: 16))
//                            .foregroundColor(fore.dark)
//                            .padding(.trailing, 30)
//
//                        Text("\(Int(temperature.value))°")
//                            .font(.custom("Groovy Dream", size: 110))
//                            .foregroundColor(fore.light)
//                    }
//                    .padding(.top, 45)
//                    .padding(.leading)
//
//                    VStack {
//                        Image ("UVsunOrange")
//                            .offset(y: 33)
//
//                        if uvIndex.category.rawValue == "Moderate" {
//                            Text("\(uvIndex.value) Mod")
//                                .font(.custom("LilitaOne", size: 15))
//                                .foregroundColor(fore.dark)
//                                .offset(y: 14)
//                                .padding(.top, 14)
//
//                        } else {
//                            Text("\(uvIndex.value)")
//                                .font(.custom("LilitaOne", size: 15))
//                                .foregroundColor(fore.dark)
//                                .offset(y: 14)
//                                .padding(.top, 14)
//
//                            Image ("UmbrellaOrange")
//                                .padding(.top, 10)
//
//                            Text("\(Int(precipitationIntensity.value))%")
//                                .font(.custom("LilitaOne", size: 15))
//                                .foregroundColor(fore.dark)
//                                .offset(y: -10)
//
//
//                        }
//
//                    }.padding(.top, 30)
//                        .ignoresSafeArea()
//                }.frame(width: 200, height:150, alignment: .top)
//                Spacer()
//
//                Text("\(String(describing: locationString ?? "-"))")
//                    .font(
//                        Font.custom("Quicksand", size: 14)
//                            .weight(.bold)
//                    )
//                    .multilineTextAlignment(.center)
//                    .foregroundColor(Color(red: 0.72, green: 0.38, blue: 0.29))
//
//                    .frame(width: 90, alignment: .center)
//                    .padding(.bottom, -10)
//
//                Spacer()
//
//            }
//            .task {
//                print("Curr : ", currWeather)
//                print("Location : ", locationString ?? "kosong")
//            }
//        }
//
//
//
//    }
//}

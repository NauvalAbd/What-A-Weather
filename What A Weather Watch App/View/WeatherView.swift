//
//  WeatherView.swift
//  What A Weather Watch App
//
//  Created by mac.bernanda on 26/05/24.
//

import SwiftUI
import WeatherKit

struct WeatherView: View {
    @State private var dragAmount = CGSize.zero
    @State private var offset = 0.0
    @State private var initialOffset = 0.0
    
    @Binding var weatherData : CurrentWeather?
    @Binding var locationString : String?
    
    @State var conditionDescription : WeatherCondition = .clear
    @State var temperatureValue : Double = 0.0
    @State var uvIndexValue : Int = 0
    @State var uvIndexCat : UVIndex.ExposureCategory = .low
    @State var precipitationIntensity : Double = 0.0
    
    var body: some View {
        ZStack{
            CustomLinearGradient(temperature: $temperatureValue, condition: $conditionDescription)
            
            ClockRadial(
                dragAmount: $dragAmount,
                offset: $offset,
                initialOffset: $initialOffset)
            
            WeatherDataView(locationString: $locationString, conditionDescription: $conditionDescription, temperatureValue: $temperatureValue, uvIndexValue: $uvIndexValue, uvIndexCat: $uvIndexCat, precipitationIntensity: $precipitationIntensity)
            
        }
        .onChange(of: weatherData) {
            if let currWeather = weatherData {
                conditionDescription = currWeather.condition
                temperatureValue = currWeather.temperature.value
                uvIndexValue = currWeather.uvIndex.value
                uvIndexCat = currWeather.uvIndex.category
                precipitationIntensity = currWeather.precipitationIntensity.value
            }
        }
    }
}

struct ExampleWeatherView: View {
    @State private var dragAmount = CGSize.zero
    @State private var offset = 0.0
    @State private var initialOffset = 0.0
    
//    Coba ganti2 ini
    @State private var temperatureValue = 29.0
    @State private var conditionDescription : WeatherCondition = .sunShowers
    
    @State private var locationString : String? = "Grogol"
    @State private var uvIndexValue = 5
    @State private var uvIndexCat = UVIndex.ExposureCategory.low
    @State private var precipitationIntensity = 0.0
    
    var body: some View {
        ZStack{
            CustomLinearGradient(temperature: $temperatureValue, condition: $conditionDescription)
            
            ClockRadial(
                dragAmount: $dragAmount,
                offset: $offset,
                initialOffset: $initialOffset)
            
            WeatherDataView(locationString: $locationString, conditionDescription: $conditionDescription, temperatureValue: $temperatureValue, uvIndexValue: $uvIndexValue, uvIndexCat: $uvIndexCat, precipitationIntensity: $precipitationIntensity)
        }
    }
}

#Preview {
    ExampleWeatherView()
}

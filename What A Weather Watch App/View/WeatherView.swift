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
    
    var body: some View {
        ZStack{
            CustomLinearGradient(weatherData: $weatherData)
            
            ClockRadial(
                dragAmount: $dragAmount,
                offset: $offset,
                initialOffset: $initialOffset)
            
            WeatherDataView(
                weatherData: $weatherData,
                locationString: $locationString)
            
        }
    }
}

struct UVIndex {
    var value: Int
    var category: UVCategory
    
    enum UVCategory: String {
        case low = "Low"
        case moderate = "Moderate"
        case high = "High"
    }
}

struct ExampleWeatherView: View {
    @State private var currentWeather: CurrentWeather?
    @State private var locationString: String? = "San Francisco"
    
    var body: some View {
        WeatherView(
            weatherData: $currentWeather,
            locationString: $locationString
        )
    }
}

#Preview {
    ExampleWeatherView()
}

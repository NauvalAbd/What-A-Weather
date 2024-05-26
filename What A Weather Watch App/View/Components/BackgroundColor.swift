//
//  BackgroundColor.swift
//  What A Weather Watch App
//
//  Created by mac.bernanda on 27/05/24.
//

import SwiftUI
import WeatherKit

struct CustomLinearGradient: View {
    @Binding var temperature: Double
    @Binding var condition: WeatherCondition
    
    var gradientColors: [Color] {
        if rainConditions.contains([condition]) {
            print("true")
            return [Color.wawGreyDarker, Color.wawGreyDark]
        }
        
        switch temperature {
        case ...26:
            return [Color.wawPinkLight, Color.wawPinkDark]
        case 27...28:
            return [Color.wawPurple, Color.wawPurpleOff]
        case 29...30:
            return [Color.wawCyanLight, Color.wawCyanDark]
        case 31...33:
            return [Color.wawLimeLight, Color.wawLime]
        case 34...:
            return [Color.wawOrangeLight, Color.wawOrangeDark]
        default:
            return [Color.wawCyanLight, Color.wawCyanDark] // Default gradient
        }
    }
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea(.all)
    }
}

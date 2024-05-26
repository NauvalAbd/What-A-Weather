//
//  MainScreenView_New.swift
//  What A Weather Watch App
//
//  Created by Nauval Abd on 22/05/24.
//

import SwiftUI
import WeatherKit
import CoreLocation

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
            WeatherView(
                weatherData: $currentWeather,
                locationString: $locationManager.locationString
            )
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
    
    func locationUpdated(location: CLLocation?, error: Error?){
        
    }
}


#Preview {
    MainScreenView_New()
}

//
//  ContentView.swift
//  What A Weather Watch App
//
//  Created by Nauval Abd on 17/05/24.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @State private var temperature: String = "--"
    @State private var weatherDescription: String = "Loading..."
    @State private var locationManager = CLLocationManager()
    @State private var userLocation: CLLocation?

    var body: some View {
//   SplashScreenView()
        MainScreenView_New()
    }
//
//    func setupLocationManager() {
//        locationManager.delegate = LocationManagerDelegate { location in
//            self.userLocation = location
//            fetchWeather(for: location)
//        }
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//    }
//
//    func fetchWeather(for location: CLLocation) {
//        let apiKey = "YOUR_API_KEY"
//        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(apiKey)&units=metric"
//
//        guard let url = URL(string: urlString) else {
//            print("Invalid URL")
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else {
//                print("Network error: \(String(describing: error))")
//                return
//            }
//
//            if let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data) {
//                DispatchQueue.main.async {
//                    self.temperature = "\(weatherResponse.main.temp)°C"
//                    self.weatherDescription = weatherResponse.weather.first?.description ?? ""
//                }
//            } else {
//                print("JSON Parsing error")
//            }
//        }.resume()
//    }
//}
//
//class LocationManagerDelegate: NSObject, CLLocationManagerDelegate {
//    var locationUpdateHandler: ((CLLocation) -> Void)?
//
//    init(locationUpdateHandler: @escaping (CLLocation) -> Void) {
//        self.locationUpdateHandler = locationUpdateHandler
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//            locationUpdateHandler?(location)
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Location error: \(error.localizedDescription)")
//    }
//}
//
//struct WeatherResponse: Codable {
//    let main: Main
//    let weather: [Weather]
//
//    struct Main: Codable {
//        let temp: Double
//    }
//
//    struct Weather: Codable {
//        let description: String
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
}

#Preview {
    ContentView()
}

//
//  LocationManager.swift
//  What A Weather Watch App
//
//  Created by Nauval Abd on 20/05/24.
//

import Foundation
/// Copyright (c) 2023 Kodeco Inc.
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
  private let manager = CLLocationManager()
  typealias LocationUpdateHandler = ((CLLocation?, Error?) -> Void)
  private var didUpdateLocation: LocationUpdateHandler?
    
    @Published var location: CLLocationCoordinate2D?
    @Published var locationString: String?

  override init() {
    super.init()
    manager.delegate = self
    manager.desiredAccuracy = kCLLocationAccuracyKilometer
    manager.requestWhenInUseAuthorization()
  }

  public func updateLocation(handler: @escaping LocationUpdateHandler) {
    self.didUpdateLocation = handler
      
      
      
    manager.startUpdatingLocation()
  }
    
    func reverseGeocoding(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (String?) -> Void) {
            let geocoder = CLGeocoder()
            let location = CLLocation(latitude: latitude, longitude: longitude)
            
            geocoder.reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                if error != nil {
                    print("Failed to retrieve address")
                    completion(nil)
                    return
                }
                
                if let placemarks = placemarks, let placemark = placemarks.first {
                    print(placemark.locality)
                    completion(placemark.locality)
                } else {
                    print("No Matching Address Found")
                    completion(nil)
                }
            })
        }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      location = locations.first?.coordinate
      
      reverseGeocoding(latitude: location?.latitude ?? 0.0, longitude: location?.longitude ?? 0.0) { locality in
                  if let locationName = locality {
                      print("Location name: - \(locationName)")
                      self.locationString = locationName
                  } else {
                      print("Failed to get location name.")
                      self.locationString = "failed"
                  }
              }
      print(locations)
    if let handler = didUpdateLocation {
      handler(locations.last, nil)
    }
    manager.stopUpdatingLocation()
  }

  func  locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    if let handler = didUpdateLocation {
      handler(nil, error)
    }
  }
}

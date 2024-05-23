//
//  WeatherData.swift
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

import Foundation
import WeatherKit
import CoreLocation
import os

class WeatherData: ObservableObject {
  let logger = Logger(subsystem: "Opal.What-A-Weather.watchkitapp", category: "Model")
  static let shared = WeatherData()
  private let service = WeatherService.shared

  func currentWeather(for location: CLLocation) async -> CurrentWeather? {
    let currentWeather = await Task.detached(priority: .userInitiated) {
      let forcast = try? await self.service.weather(
        for: location,
        including: .current)
      return forcast
    }.value
    return currentWeather
  }

  func dailyForecast(for location: CLLocation) async -> Forecast<DayWeather>? {
    let dayWeather = await Task.detached(priority: .userInitiated) {
      let forcast = try? await self.service.weather(
        for: location,
        including: .daily)
      return forcast
    }.value
    return dayWeather
  }

  func hourlyForecast(for location: CLLocation) async -> Forecast<HourWeather>? {
    let hourWeather = await Task.detached(priority: .userInitiated) {
      let forcast = try? await self.service.weather(
        for: location,
        including: .hourly)
      return forcast
    }.value
    return hourWeather
  }

  func weatherAttribution() async -> WeatherAttribution? {
    let attrib = await Task.detached(priority: .userInitiated) {
      return try? await self.service.attribution
    }.value
    return attrib
  }
}


enum WeatherDataHelper {
  public static func findDailyTempMinMax(_ daily: Forecast<DayWeather>) -> (min: Double, max: Double) {
    let minElement = daily.min { valA, valB in
      valA.lowTemperature.value < valB.lowTemperature.value
    }
    let min = minElement?.lowTemperature.value ?? 0

    let maxElement = daily.max { valA, valB in
      valA.highTemperature.value < valB.highTemperature.value
    }
    let max = maxElement?.highTemperature.value ?? 200

    return (min, max)
  }

  static func findHourlyTempMinMax(_ hourly: Forecast<HourWeather>) -> (min: Double, max: Double) {
    let minElement = hourly.min { valA, valB in
      valA.temperature.value < valB.temperature.value
    }
    let min = minElement?.temperature.value ?? 0

    let maxElement = hourly.max { valA, valB in
      valA.temperature.value < valB.temperature.value
    }
    let max = maxElement?.temperature.value ?? 200

    return (min, max)
  }
}

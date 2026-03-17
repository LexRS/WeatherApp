//
//  Entity.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 11.03.2026.
//

import Foundation
import UIKit

struct WeatherEntity {
    let current: Weather
    let hourly: [HourWeather]
    let days: [DayWeather]
}

struct Weather {
    let city: String
    let temperature: Double
    let condition: WeatherCondition
    let image: UIImage?
}

struct HourWeather {
    let date: Date
    let temperature: Double
    let image: UIImage?
}

struct DayWeather {
    let date: Date
    let minTemp: Double
    let maxTemp: Double
    let image: UIImage?
}

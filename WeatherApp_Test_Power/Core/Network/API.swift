//
//  API.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 11.03.2026.
//

import Foundation

struct API {
    static let key = "fa8b3df74d4042b9aa7135114252304"

    static func current(lat: Double, lon: Double) -> String {
        return "https://api.weatherapi.com/v1/current.json?key=\(key)&q=\(lat),\(lon)"
    }
    
    static func forecast(lat: Double, lon: Double) -> String {
        return "https://api.weatherapi.com/v1/forecast.json?key=\(key)&q=\(lat),\(lon)&days=3"
    }
}

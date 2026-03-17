//
//  Endpoint.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 11.03.2026.
//

import Foundation

struct Endpoint {
    let url: URL

    static func current(lat: Double, lon: Double) -> Endpoint {
        let url = URL(string: API.current(lat: lat, lon: lon))!

        return Endpoint(url: url)
    }

    static func forecast(lat: Double, lon: Double) -> Endpoint {
        let url = URL(string: API.forecast(lat: lat, lon: lon))!

        return Endpoint(url: url)
    }
}

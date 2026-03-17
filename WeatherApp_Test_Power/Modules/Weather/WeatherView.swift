//
//  WeatherView.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 11.03.2026.
//

protocol WeatherView: AnyObject {
    func render(_ state: WeatherViewState)
}

enum WeatherViewState {
    case loading
    case content(WeatherModel)
    case error(String)
}

//
//  WeatherRepository.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 11.03.2026.
//

import Foundation
import UIKit

protocol WeatherRepositoryProtocol {
    func fetchWeather(lat: Double, lon: Double) async throws -> (CurrentDTO, ForecastDTO, [String: UIImage])
}

final class WeatherRepository: WeatherRepositoryProtocol {
    private let api: APIClient
    private let imageLoader: ImageLoaderProtocol
    
    init(
        api: APIClient,
        imageLoader: ImageLoaderProtocol,
    ) {
        self.api = api
        self.imageLoader = imageLoader
    }
    
    func fetchWeather(lat: Double, lon: Double) async throws -> (CurrentDTO, ForecastDTO, [String: UIImage]) {
        async let currentWeather: CurrentDTO = api.request(.current(lat: lat, lon: lon))
        async let forecast: ForecastDTO = api.request(.forecast(lat: lat, lon: lon))
        
        let (currentWeatherResponse, forecastResponse) = try await (currentWeather, forecast)
        
        let imagesByUrls = try await imageLoader.loadImages(for: currentWeatherResponse, for: forecastResponse)
        
        return (currentWeatherResponse, forecastResponse, imagesByUrls)
    }
}

//
//  GetWeatherUseCase.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 11.03.2026.
//

import CoreLocation

protocol GetWeatherUseCaseProtocol: AnyObject {
    func getLocation() async throws -> CLLocationCoordinate2D
    func getDefaultLocation() -> CLLocationCoordinate2D
    func getWeatherModel(for location: CLLocationCoordinate2D) async throws -> WeatherModel
}

final class GetWeatherUseCase: GetWeatherUseCaseProtocol {
    
    private let repository: WeatherRepositoryProtocol
    private let locationService: LocationServiceProtocol
    private let weatherMapper: WeatherMapperProtocol

    init(
        repository: WeatherRepositoryProtocol,
        locationService: LocationServiceProtocol,
        weatherMapper: WeatherMapperProtocol
    ) {
        self.repository = repository
        self.locationService = locationService
        self.weatherMapper = weatherMapper
    }
    
    func getLocation() async throws -> CLLocationCoordinate2D {
        try await locationService.getLocation()
    }
    
    func getDefaultLocation() -> CLLocationCoordinate2D {
        locationService.moscowLocation
    }
    
    func getWeatherModel(for location: CLLocationCoordinate2D) async throws -> WeatherModel {
        let weatherData = try await repository.fetchWeather(
            lat: location.latitude,
            lon: location.longitude
        )
        let weatherEntity = weatherMapper.mapToEntity(
            currentData: weatherData.0,
            forecastData: weatherData.1,
            imagesByUrls: weatherData.2
        )
        
        let isDaytime = locationService.isDaytime(for: location)
        return weatherMapper.mapToModel(entity: weatherEntity, isDaytime: false)
    }
}

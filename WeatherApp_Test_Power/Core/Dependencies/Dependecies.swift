//
//  Dependecies.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 11.03.2026.
//

final class Dependecies {
    private let container = ServiceLocator.shared
    
    init() {
        api()
        imageLoader()
        repository()
        location()
        dateParser()
        mapper()
    }
    
    private func api() {
        let api = APIClient()
        container.register {
            api
        }
    }
    
    private func imageLoader() {
        let imageLoader = ImageLoader()
        container.register {
            imageLoader as ImageLoaderProtocol
        }
    }
    
    private func repository() {
        let api: APIClient = container.resolve()
        let imageLoader: ImageLoaderProtocol = container.resolve()
        let repository = WeatherRepository(api: api, imageLoader: imageLoader)
        container.register {
            repository as WeatherRepositoryProtocol
        }
    }
    
    private func location() {
        let locationService = LocationService()
        container.register {
            locationService as LocationServiceProtocol
        }
    }
    
    private func dateParser() {
        let parser = DateParser()
        container.register {
            parser as DateFormatting
        }
    }
    
    private func mapper() {
        let parser: DateFormatting = container.resolve()
        let mapper = WeatherMapperBuilder.createMapper(dateParser: parser)
        container.register {
            mapper as WeatherMapperProtocol
        }
    }
}

// MARK: - Public

extension Dependecies {
    func getWeatherUseCase() -> GetWeatherUseCaseProtocol {
        let repository: WeatherRepositoryProtocol = container.resolve()
        let locationService: LocationServiceProtocol = container.resolve()
        let mapper: WeatherMapperProtocol = container.resolve()
        let result = GetWeatherUseCase(
            repository: repository,
            locationService: locationService,
            weatherMapper: mapper
        )
        return result
    }
}

//
//  WeatherPresenter.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 11.03.2026.
//

internal import _LocationEssentials

protocol WeatherPresenterProtocol: AnyObject {
    func retryTapped()
}

final class WeatherPresenter: WeatherPresenterProtocol {
    weak var view: WeatherView?

    private let useCase: GetWeatherUseCaseProtocol

    init(useCase: GetWeatherUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func viewDidLoad() {
        loadWeather()
    }

    func loadWeather() {
        guard let view else { return }
        Task {
            await MainActor.run {
                view.render(.loading)
            }
            do {
                let location = try await useCase.getLocation()
                let model = try await useCase.getWeatherModel(for: location)
                await MainActor.run {
                    view.render(.content(model))
                }
            } catch {
                do {
                    let location = useCase.getDefaultLocation()
                    let model = try await useCase.getWeatherModel(for: location)
                    await MainActor.run {
                        view.render(.content(model))
                    }
                } catch {
                    await MainActor.run {
                        view.render(.error(error.localizedDescription))
                    }
                }
            }
        }
    }
}

extension WeatherPresenter {
    func retryTapped() {
        loadWeather()
    }
}

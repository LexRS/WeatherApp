//
//  Factory.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 11.03.2026.
//

import UIKit

final class WeatherModuleFactory {
    static func build(with useCase: GetWeatherUseCaseProtocol) -> UIViewController {
        let presenter = WeatherPresenter(useCase: useCase)
        let viewController = WeatherViewController(presenter: presenter)
        presenter.view = viewController

        return viewController
    }
}

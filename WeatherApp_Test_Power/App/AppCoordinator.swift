//
//  AppCoordinator.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 11.03.2026.
//

import UIKit

protocol Coordinator: AnyObject {
    func start()
}

final class AppCoordinator: Coordinator {
    private let window: UIWindow
    private let navigationController = UINavigationController()
    private var dependencies = Dependecies()

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        setRootViewController()
    }
}

private extension AppCoordinator {
    func setRootViewController() {
        let weatherUseCase = dependencies.getWeatherUseCase()
        let module = WeatherModuleBuilder.build(with: weatherUseCase)
        navigationController.setViewControllers(
            [module],
            animated: false
        )
    }
}

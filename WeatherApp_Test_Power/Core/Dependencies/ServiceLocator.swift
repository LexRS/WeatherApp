//
//  ServiceLocator.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 11.03.2026.
//

protocol ServiceLocating {
    func register<T>(_ service: @escaping () -> T)
    func clearServices()
    func resolve<T>() -> T
}

final class ServiceLocator: ServiceLocating {
    static let shared = ServiceLocator()
    
    private var container: [ObjectIdentifier: Any] = [:]

    init() {}

    func register<T>(_ service: @escaping () -> T) {
        container[ObjectIdentifier(T.self)] = service
    }

    func clearServices() {
        container = [:]
    }

    func resolve<T>() -> T {
        guard let service = container[ObjectIdentifier(T.self)] as? () -> T else {
            preconditionFailure("Could not locate \(T.self)")
        }

        return service()
    }
}

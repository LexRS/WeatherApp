//
//  LocationService.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 11.03.2026.
//

import CoreLocation
import SwiftSunriseSunset

protocol LocationServiceProtocol {
    var moscowLocation: CLLocationCoordinate2D { get }
    func getLocation() async throws -> CLLocationCoordinate2D
    func isDaytime(for location: CLLocationCoordinate2D) -> Bool
}

final class LocationService: NSObject, LocationServiceProtocol {
    
    let moscowLocation = CLLocationCoordinate2D(latitude: 55.7558, longitude: 37.6173)
    private let manager = CLLocationManager()

    private var locationContinuation:
        CheckedContinuation<CLLocationCoordinate2D, Error>?

    private var authContinuation:
        CheckedContinuation<Void, Error>?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func getLocation() async throws -> CLLocationCoordinate2D {
        try await requestAuthorization()
        return try await requestLocation()
    }
    
    func isDaytime(for location: CLLocationCoordinate2D) -> Bool {
        let now = Date()
        let timeZone = TimeZone.current // Use the user's current time zone
        
        // Calculate sunrise and sunset times for the current date and location
        guard let sunrise = SwiftSunriseSunset.sunrise(for: now, in: timeZone, at: location),
              let sunset = SwiftSunriseSunset.sunset(for: now, in: timeZone, at: location) else {
            // Fallback or handle cases where sun never rises/sets (e.g., extreme poles)
            return true // Default to daytime if calculation fails
        }
        
        // Check if the current time falls within the day range (after sunrise and before sunset)
        return now >= sunrise && now < sunset
    }
}

private extension LocationService {
    func requestAuthorization() async throws {
        let status = manager.authorizationStatus
        if status == .authorizedWhenInUse ||
           status == .authorizedAlways {
            return
        }

        if status == .denied || status == .restricted {
            throw LocationError.denied
        }

        return try await withCheckedThrowingContinuation { continuation in
            authContinuation = continuation
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        }
    }
}

private extension LocationService {
    func requestLocation() async throws -> CLLocationCoordinate2D {
        return try await withCheckedThrowingContinuation { continuation in
            locationContinuation = continuation
            manager.requestLocation()
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.first else { return }
        locationContinuation?.resume(
            returning: location.coordinate
        )

        locationContinuation = nil
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        locationContinuation?.resume(
            throwing: error
        )

        locationContinuation = nil
    }

    func locationManagerDidChangeAuthorization(
        _ manager: CLLocationManager
    ) {
        let status = manager.authorizationStatus

        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            authContinuation?.resume()
        case .denied, .restricted:
            authContinuation?.resume(
                throwing: LocationError.denied
            )
        default:
            break
        }

        authContinuation = nil
    }
}

enum LocationError: Error {
    case denied
    case unableToFindLocation
}

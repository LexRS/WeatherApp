//
//  ImageLoader.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 11.03.2026.
//

import Foundation
import UIKit

enum ImageLoadingError: Error {
    case invalidData(URL)
    case networkError(URL, Error)
    case deallocatedImageLoader
    case invalidURL
}

protocol ImageLoaderProtocol: AnyObject {
    func loadImages(for currentWeatherData: CurrentDTO, for forecastData: ForecastDTO) async throws -> [String: UIImage]
}

final class ImageLoader: ImageLoaderProtocol {
    private let cache = NSCache<NSURL, UIImage>()
    
    func loadImages(for currentWeatherData: CurrentDTO, for forecastData: ForecastDTO) async throws -> [String: UIImage] {
        var urls = Set<String>()
        
        urls.insert(currentWeatherData.current.condition.icon)
        
        for forecastForDay in forecastData.forecast.forecastday {
            urls.insert(forecastForDay.day.condition.icon)
            for forecastForHour in forecastForDay.hour {
                urls.insert(forecastForHour.condition.icon)
            }
        }
        
        return try await loadImages(from: urls)
    }

    private func loadImage(_ url: URL?) async throws -> UIImage {
        guard let url else {
            throw ImageLoadingError.invalidURL
        }
        if let cached = cache.object(forKey: url as NSURL) {
            return cached
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw ImageLoadingError.invalidData(url)
        }
        cache.setObject(image, forKey: url as NSURL)

        return image
    }
    
    private func loadImages(from urlStrings: Set<String>) async throws -> [String: UIImage] {
        try await withThrowingTaskGroup(of: (String, UIImage).self) { group in
            for urlString in urlStrings {
                group.addTask(priority: .userInitiated) { [weak self] in
                    guard let self else {
                        throw ImageLoadingError.deallocatedImageLoader
                    }
                    guard let url = urlString.createImageUrl() else {
                        throw ImageLoadingError.invalidURL
                    }
                    let image = try await self.loadImage(url)
                    return (urlString, image)
                }
            }
            
            var imageDictionary: [String: UIImage] = [:]
            for try await (url, image) in group {
                imageDictionary[url] = image
            }
            
            return imageDictionary
        }
    }
}

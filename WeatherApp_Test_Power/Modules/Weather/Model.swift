//
//  Model.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 11.03.2026.
//

import Foundation
import UIKit

struct WeatherModel {
    struct Current {
        let city: String
        let temperature: String
        let condition: WeatherCondition
        let image: UIImage?
        let isDaytime: Bool
    }

    struct Hour {
        let time: String
        let temperature: String
        let image: UIImage?
    }

    struct Day {
        let date: String
        let minTemp: String
        let maxTemp: String
        let image: UIImage?
    }

    let current: Current
    let hourly: [Hour]
    let days: [Day]
}

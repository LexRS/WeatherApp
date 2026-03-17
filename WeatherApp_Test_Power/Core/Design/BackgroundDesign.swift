//
//  BackgroundDesign.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 16.03.2026.
//

import Foundation
import UIKit

enum BackgroundDesign {
    static func getColors(for condition: WeatherCondition, isDaytime: Bool) -> [UIColor] {
        switch condition {
            // ☀️ Clear/Sunny conditions
        case .sunny, .clear, .unknown:
            if isDaytime {
                return [
                    UIColor(red: 0.98, green: 0.85, blue: 0.38, alpha: 1.0), // Warm yellow
                    UIColor(red: 0.95, green: 0.68, blue: 0.28, alpha: 1.0)  // Orange-yellow
                ]
            } else {
                return [
                    UIColor(red: 0.10, green: 0.12, blue: 0.22, alpha: 1.0), // Dark blue
                    UIColor(red: 0.05, green: 0.08, blue: 0.18, alpha: 1.0), // Almost black
                    UIColor(red: 0.22, green: 0.18, blue: 0.30, alpha: 1.0)  // Deep purple
                ]
            }
            
            // ⛅ Partly cloudy
        case .partlyCloudy:
            if isDaytime {
                return [
                    UIColor(red: 0.53, green: 0.81, blue: 0.98, alpha: 1.0), // Light blue
                    UIColor(red: 0.85, green: 0.90, blue: 0.95, alpha: 1.0), // Cloud white
                    UIColor(red: 0.70, green: 0.80, blue: 0.90, alpha: 1.0)  // Soft gray-blue
                ]
            } else {
                return [
                    UIColor(red: 0.20, green: 0.25, blue: 0.35, alpha: 1.0), // Dark gray-blue
                    UIColor(red: 0.30, green: 0.28, blue: 0.35, alpha: 1.0), // Purple-gray
                    UIColor(red: 0.15, green: 0.18, blue: 0.25, alpha: 1.0)  // Deep blue-gray
                ]
            }
            
            // ☁️ Cloudy/Overcast
        case .cloudy, .overcast:
            return [
                UIColor(red: 0.65, green: 0.70, blue: 0.75, alpha: 1.0), // Light gray
                UIColor(red: 0.45, green: 0.50, blue: 0.55, alpha: 1.0), // Medium gray
                UIColor(red: 0.30, green: 0.35, blue: 0.40, alpha: 1.0)  // Dark gray
            ]
            
            // 🌫️ Fog/Mist
        case .mist, .fog, .freezingFog:
            return [
                UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0), // White-gray
                UIColor(red: 0.70, green: 0.72, blue: 0.75, alpha: 1.0), // Light gray
                UIColor(red: 0.60, green: 0.62, blue: 0.65, alpha: 1.0)  // Medium gray
            ]
            
            // 🌧️ Rain conditions
        case .patchyRainPossible, .patchyLightRain, .lightRain, .moderateRainAtTimes,
                .moderateRain, .heavyRainAtTimes, .heavyRain, .lightRainShower,
                .moderateOrHeavyRainShower, .torrentialRainShower:
            return [
                UIColor(red: 0.40, green: 0.50, blue: 0.65, alpha: 1.0), // Slate blue
                UIColor(red: 0.30, green: 0.40, blue: 0.55, alpha: 1.0), // Darker slate
                UIColor(red: 0.20, green: 0.30, blue: 0.45, alpha: 1.0)  // Deep slate
            ]
            
            // ❄️ Snow conditions
        case .patchySnowPossible, .lightSnow, .moderateSnow, .heavySnow,
                .patchyLightSnow, .patchyModerateSnow, .patchyHeavySnow,
                .lightSnowShowers, .moderateOrHeavySnowShowers:
            if isDaytime {
                return [
                    UIColor(red: 0.90, green: 0.95, blue: 1.00, alpha: 1.0), // Ice white
                    UIColor(red: 0.75, green: 0.85, blue: 0.95, alpha: 1.0), // Light blue-white
                    UIColor(red: 0.85, green: 0.92, blue: 1.00, alpha: 1.0)  // Pale blue
                ]
            } else {
                return [
                    UIColor(red: 0.30, green: 0.40, blue: 0.55, alpha: 1.0), // Night blue
                    UIColor(red: 0.25, green: 0.35, blue: 0.50, alpha: 1.0), // Darker blue
                    UIColor(red: 0.20, green: 0.25, blue: 0.35, alpha: 1.0)  // Very dark blue
                ]
            }
            
            // 🌨️ Sleet/Freezing rain
        case .patchySleetPossible, .lightSleet, .moderateOrHeavySleet,
                .lightFreezingRain, .moderateOrHeavyFreezingRain, .lightSleetShowers,
                .patchyFreezingDrizzlePossible, .freezingDrizzle, .heavyFreezingDrizzle, .moderateOrHeavySleetShowers:
            return [
                UIColor(red: 0.55, green: 0.65, blue: 0.75, alpha: 1.0), // Cold blue
                UIColor(red: 0.40, green: 0.50, blue: 0.65, alpha: 1.0), // Steel blue
                UIColor(red: 0.30, green: 0.40, blue: 0.55, alpha: 1.0)  // Deep steel
            ]
            
            // 🌨️ Blizzard/Blowing snow
        case .blowingSnow, .blizzard:
            return [
                UIColor(red: 0.95, green: 0.98, blue: 1.00, alpha: 1.0), // Almost white
                UIColor(red: 0.70, green: 0.80, blue: 0.90, alpha: 1.0), // Ice blue
                UIColor(red: 0.50, green: 0.60, blue: 0.75, alpha: 1.0)  // Gray-blue
            ]
            
            // ⛈️ Thunderstorms
        case .thunderyOutbreaksPossible, .patchyLightRainWithThunder,
                .moderateOrHeavyRainWithThunder, .patchyLightSnowWithThunder,
                .moderateOrHeavySnowWithThunder:
            return [
                UIColor(red: 0.20, green: 0.20, blue: 0.25, alpha: 1.0), // Dark storm
                UIColor(red: 0.30, green: 0.25, blue: 0.30, alpha: 1.0), // Purple-gray
                UIColor(red: 0.15, green: 0.15, blue: 0.20, alpha: 1.0)  // Almost black
            ]
            
            // 🧊 Ice pellets
        case .icePellets, .lightShowersOfIcePellets, .moderateOrHeavyShowersOfIcePellets:
            return [
                UIColor(red: 0.70, green: 0.80, blue: 0.90, alpha: 1.0), // Light ice
                UIColor(red: 0.55, green: 0.65, blue: 0.80, alpha: 1.0), // Medium ice
                UIColor(red: 0.40, green: 0.50, blue: 0.70, alpha: 1.0)  // Deep ice
            ]
            
            // 🌧️ Drizzle
        case .patchyLightDrizzle, .lightDrizzle:
            return [
                UIColor(red: 0.60, green: 0.70, blue: 0.80, alpha: 1.0), // Soft blue
                UIColor(red: 0.50, green: 0.60, blue: 0.75, alpha: 1.0), // Medium blue-gray
                UIColor(red: 0.40, green: 0.50, blue: 0.65, alpha: 1.0)  // Deeper blue-gray
            ]
        }
    }
}

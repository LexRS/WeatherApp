//
//  WeatherCondition.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 16.03.2026.
//

import Foundation

enum WeatherCondition: String, CaseIterable, Codable {
    case sunny
    case clear
    case partlyCloudy
    case cloudy
    case overcast
    case mist
    case patchyRainPossible
    case patchySnowPossible
    case patchySleetPossible
    case patchyFreezingDrizzlePossible
    case thunderyOutbreaksPossible
    case blowingSnow
    case blizzard
    case fog
    case freezingFog
    case patchyLightDrizzle
    case lightDrizzle
    case freezingDrizzle
    case heavyFreezingDrizzle
    case patchyLightRain
    case lightRain
    case moderateRainAtTimes
    case moderateRain
    case heavyRainAtTimes
    case heavyRain
    case lightFreezingRain
    case moderateOrHeavyFreezingRain
    case lightSleet
    case moderateOrHeavySleet
    case patchyLightSnow
    case lightSnow
    case patchyModerateSnow
    case moderateSnow
    case patchyHeavySnow
    case heavySnow
    case icePellets
    case lightRainShower
    case moderateOrHeavyRainShower
    case torrentialRainShower
    case lightSleetShowers
    case moderateOrHeavySleetShowers
    case lightSnowShowers
    case moderateOrHeavySnowShowers
    case lightShowersOfIcePellets
    case moderateOrHeavyShowersOfIcePellets
    case patchyLightRainWithThunder
    case moderateOrHeavyRainWithThunder
    case patchyLightSnowWithThunder
    case moderateOrHeavySnowWithThunder
    case unknown
    
    // MARK: - Display Properties
    var displayName: String {
        switch self {
        case .sunny: return "Sunny"
        case .clear: return "Clear"
        case .partlyCloudy: return "Partly Cloudy"
        case .cloudy: return "Cloudy"
        case .overcast: return "Overcast"
        case .mist: return "Mist"
        case .patchyRainPossible: return "Patchy Rain Possible"
        case .patchySnowPossible: return "Patchy Snow Possible"
        case .patchySleetPossible: return "Patchy Sleet Possible"
        case .patchyFreezingDrizzlePossible: return "Patchy Freezing Drizzle Possible"
        case .thunderyOutbreaksPossible: return "Thundery Outbreaks Possible"
        case .blowingSnow: return "Blowing Snow"
        case .blizzard: return "Blizzard"
        case .fog: return "Fog"
        case .freezingFog: return "Freezing Fog"
        case .patchyLightDrizzle: return "Patchy Light Drizzle"
        case .lightDrizzle: return "Light Drizzle"
        case .freezingDrizzle: return "Freezing Drizzle"
        case .heavyFreezingDrizzle: return "Heavy Freezing Drizzle"
        case .patchyLightRain: return "Patchy Light Rain"
        case .lightRain: return "Light Rain"
        case .moderateRainAtTimes: return "Moderate Rain at Times"
        case .moderateRain: return "Moderate Rain"
        case .heavyRainAtTimes: return "Heavy Rain at Times"
        case .heavyRain: return "Heavy Rain"
        case .lightFreezingRain: return "Light Freezing Rain"
        case .moderateOrHeavyFreezingRain: return "Moderate or Heavy Freezing Rain"
        case .lightSleet: return "Light Sleet"
        case .moderateOrHeavySleet: return "Moderate or Heavy Sleet"
        case .patchyLightSnow: return "Patchy Light Snow"
        case .lightSnow: return "Light Snow"
        case .patchyModerateSnow: return "Patchy Moderate Snow"
        case .moderateSnow: return "Moderate Snow"
        case .patchyHeavySnow: return "Patchy Heavy Snow"
        case .heavySnow: return "Heavy Snow"
        case .icePellets: return "Ice Pellets"
        case .lightRainShower: return "Light Rain Shower"
        case .moderateOrHeavyRainShower: return "Moderate or Heavy Rain Shower"
        case .torrentialRainShower: return "Torrential Rain Shower"
        case .lightSleetShowers: return "Light Sleet Showers"
        case .moderateOrHeavySleetShowers: return "Moderate or Heavy Sleet Showers"
        case .lightSnowShowers: return "Light Snow Showers"
        case .moderateOrHeavySnowShowers: return "Moderate or Heavy Snow Showers"
        case .lightShowersOfIcePellets: return "Light Showers of Ice Pellets"
        case .moderateOrHeavyShowersOfIcePellets: return "Moderate or Heavy Showers of Ice Pellets"
        case .patchyLightRainWithThunder: return "Patchy Light Rain with Thunder"
        case .moderateOrHeavyRainWithThunder: return "Moderate or Heavy Rain with Thunder"
        case .patchyLightSnowWithThunder: return "Patchy Light Snow with Thunder"
        case .moderateOrHeavySnowWithThunder: return "Moderate or Heavy Snow with Thunder"
        case .unknown: return "Unknown value"
        }
    }
    
    // MARK: - Initialization from API String
    init(apiString: String) {
        let mapping: [String: WeatherCondition] = [
            "Sunny": .sunny,
            "Clear": .clear,
            "Partly cloudy": .partlyCloudy,
            "Cloudy": .cloudy,
            "Overcast": .overcast,
            "Mist": .mist,
            "Patchy rain possible": .patchyRainPossible,
            "Patchy snow possible": .patchySnowPossible,
            "Patchy sleet possible": .patchySleetPossible,
            "Patchy freezing drizzle possible": .patchyFreezingDrizzlePossible,
            "Thundery outbreaks possible": .thunderyOutbreaksPossible,
            "Blowing snow": .blowingSnow,
            "Blizzard": .blizzard,
            "Fog": .fog,
            "Freezing fog": .freezingFog,
            "Patchy light drizzle": .patchyLightDrizzle,
            "Light drizzle": .lightDrizzle,
            "Freezing drizzle": .freezingDrizzle,
            "Heavy freezing drizzle": .heavyFreezingDrizzle,
            "Patchy light rain": .patchyLightRain,
            "Light rain": .lightRain,
            "Moderate rain at times": .moderateRainAtTimes,
            "Moderate rain": .moderateRain,
            "Heavy rain at times": .heavyRainAtTimes,
            "Heavy rain": .heavyRain,
            "Light freezing rain": .lightFreezingRain,
            "Moderate or heavy freezing rain": .moderateOrHeavyFreezingRain,
            "Light sleet": .lightSleet,
            "Moderate or heavy sleet": .moderateOrHeavySleet,
            "Patchy light snow": .patchyLightSnow,
            "Light snow": .lightSnow,
            "Patchy moderate snow": .patchyModerateSnow,
            "Moderate snow": .moderateSnow,
            "Patchy heavy snow": .patchyHeavySnow,
            "Heavy snow": .heavySnow,
            "Ice pellets": .icePellets,
            "Light rain shower": .lightRainShower,
            "Moderate or heavy rain shower": .moderateOrHeavyRainShower,
            "Torrential rain shower": .torrentialRainShower,
            "Light sleet showers": .lightSleetShowers,
            "Moderate or heavy sleet showers": .moderateOrHeavySleetShowers,
            "Light snow showers": .lightSnowShowers,
            "Moderate or heavy snow showers": .moderateOrHeavySnowShowers,
            "Light showers of ice pellets": .lightShowersOfIcePellets,
            "Moderate or heavy showers of ice pellets": .moderateOrHeavyShowersOfIcePellets,
            "Patchy light rain with thunder": .patchyLightRainWithThunder,
            "Moderate or heavy rain with thunder": .moderateOrHeavyRainWithThunder,
            "Patchy light snow with thunder": .patchyLightSnowWithThunder,
            "Moderate or heavy snow with thunder": .moderateOrHeavySnowWithThunder
        ]
        
        guard let condition = mapping[apiString] else {
            self = .unknown
            return
        }
        self = condition
    }
}

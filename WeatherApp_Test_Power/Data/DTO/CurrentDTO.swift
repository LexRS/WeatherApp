//
//  CurrentDTO.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 11.03.2026.
//

import Foundation

nonisolated struct CurrentDTO: Decodable {
    let location: LocationDTO
    let current: CurrentWeatherDTO
}

struct LocationDTO: Decodable {
    let name: String
}

struct CurrentWeatherDTO: Decodable {
    let tempC: Double
    let condition: ConditionDTO

    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case condition
    }
}

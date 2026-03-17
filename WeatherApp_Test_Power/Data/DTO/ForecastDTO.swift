//
//  ForecastDTO.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 11.03.2026.
//

import Foundation

nonisolated struct ForecastDTO: Decodable {
    let forecast: ForecastContainerDTO
}

struct ForecastContainerDTO: Decodable {
    let forecastday: [ForecastDayDTO]
}

struct ForecastDayDTO: Decodable {
    let date: String
    let day: DayDTO
    let hour: [HourDTO]
}

struct DayDTO: Decodable {
    let maxTempC: Double
    let minTempC: Double
    let condition: ConditionDTO

    enum CodingKeys: String, CodingKey {
        case maxTempC = "maxtemp_c"
        case minTempC = "mintemp_c"
        case condition
    }
}

struct HourDTO: Decodable {
    let time: String
    let tempC: Double
    let condition: ConditionDTO

    enum CodingKeys: String, CodingKey {
        case time
        case tempC = "temp_c"
        case condition
    }
}

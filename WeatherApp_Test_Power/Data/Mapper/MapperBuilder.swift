//
//  MapperBuilder.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 17.03.2026.
//

class WeatherMapperBuilder {
    static func createMapper(dateParser: DateFormatting) -> WeatherMapperProtocol {
        let parser = dateParser
        return WeatherMapper(dateParser: parser)
    }
}

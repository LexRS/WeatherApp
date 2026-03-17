//
//  WeatherMapper.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 11.03.2026.
//

import Foundation
import UIKit

protocol WeatherMapperProtocol {
    func mapToEntity(currentData: CurrentDTO, forecastData: ForecastDTO, imagesByUrls: [String: UIImage]) -> WeatherEntity
    func mapToModel(entity: WeatherEntity, isDaytime: Bool) -> WeatherModel
}

class WeatherMapper: WeatherMapperProtocol{
    private let dateParser: DateFormatting
    private let calendar: Calendar
    
    init(dateParser: DateFormatting, calendar: Calendar = .current) {
        self.dateParser = dateParser
        self.calendar = calendar
    }
    
    func mapToEntity(currentData: CurrentDTO, forecastData: ForecastDTO, imagesByUrls: [String: UIImage]) -> WeatherEntity {
        let weatherCondition = WeatherCondition(apiString: currentData.current.condition.text)
        
        let currentWeather = Weather(
            city: currentData.location.name,
            temperature: currentData.current.tempC,
            condition: weatherCondition,
            image: imagesByUrls[currentData.current.condition.icon]
        )
        
        let hourly = mapHourlyWeather(from: forecastData, imagesByUrls: imagesByUrls)
        let days = mapDailyWeather(from: forecastData, imagesByUrls: imagesByUrls)
        
        return WeatherEntity(
            current: currentWeather,
            hourly: hourly,
            days: days
        )
    }
    
    func mapToModel(entity: WeatherEntity, isDaytime: Bool) -> WeatherModel {
        let current = mapCurrentToModel(entity.current, isDaytime: isDaytime)
        let hourly = filterAndMapHourlyWeather(entity.hourly)
        let days = mapDailyToViewModel(entity.days)
        
        return WeatherModel(
            current: current,
            hourly: hourly,
            days: days
        )
    }
    
    // MARK: - Private Mapping Methods
    
    private func mapHourlyWeather(from forecastData: ForecastDTO, imagesByUrls: [String: UIImage]) -> [HourWeather] {
        return forecastData.forecast.forecastday
            .flatMap { $0.hour }
            .compactMap { hour in
                guard let date = dateParser.parseHour(hour.time) else { return nil }
                return HourWeather(
                    date: date,
                    temperature: hour.tempC,
                    image: imagesByUrls[hour.condition.icon]
                )
            }
    }
    
    private func mapDailyWeather(from forecastData: ForecastDTO, imagesByUrls: [String: UIImage]) -> [DayWeather] {
        return forecastData.forecast.forecastday.compactMap { day in
            guard let date = dateParser.parseDay(day.date) else { return nil }
            return DayWeather(
                date: date,
                minTemp: day.day.minTempC,
                maxTemp: day.day.maxTempC,
                image: imagesByUrls[day.day.condition.icon]
            )
        }
    }
    
    private func mapCurrentToModel(_ current: Weather, isDaytime: Bool) -> WeatherModel.Current {
        WeatherModel.Current(
            city: current.city,
            temperature: formatTemperature(current.temperature),
            condition: current.condition,
            image: current.image,
            isDaytime: isDaytime
        )
    }
    
    private func mapHourToModel(_ hour: HourWeather) -> WeatherModel.Hour {
        WeatherModel.Hour(
            time: dateParser.formatHour(hour.date),
            temperature: formatTemperature(hour.temperature),
            image: hour.image
        )
    }
    
    private func mapDayToModel(_ day: DayWeather) -> WeatherModel.Day {
        WeatherModel.Day(
            date: dateParser.formatDay(day.date),
            minTemp: formatTemperature(day.minTemp),
            maxTemp: formatTemperature(day.maxTemp),
            image: day.image
        )
    }
    
    private func filterAndMapHourlyWeather(_ hours: [HourWeather]) -> [WeatherModel.Hour] {
        let now = Date()
        let endDate = calendar.date(byAdding: .day, value: 1, to: now)!
        
        let filteredHours = hours.filter { hour in
            return hour.date >= now && hour.date <= endDate
        }
        
        return filteredHours.map(mapHourToModel)
    }
    
    private func mapDailyToViewModel(_ days: [DayWeather]) -> [WeatherModel.Day] {
        return days.prefix(3).map(mapDayToModel)
    }
    
    private func formatTemperature(_ temp: Double) -> String {
        return "\(Int(temp))°"
    }
}

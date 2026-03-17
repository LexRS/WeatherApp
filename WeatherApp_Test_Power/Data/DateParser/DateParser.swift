//
//  DateParser.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 11.03.2026.
//

import Foundation

protocol DateFormatting: AnyObject {
    func parseDay(_ string: String) -> Date?
    func parseHour(_ string: String) -> Date?
    func formatDay(_ date: Date) -> String
    func formatHour(_ date: Date) -> String
}

class DateParser: DateFormatting {
    private let dayParser: DateFormatter
    private let hourParser: DateFormatter
    private let dayFormatter: DateFormatter
    private let hourFormatter: DateFormatter
    
    init(calendar: Calendar = .current, timeZone: TimeZone = .current) {
        self.dayParser = DateFormatter()
        self.dayParser.dateFormat = "yyyy-MM-dd"
        self.dayParser.calendar = calendar
        self.dayParser.timeZone = timeZone
        self.dayParser.locale = Locale(identifier: "en_US_POSIX")
        
        self.hourParser = DateFormatter()
        self.hourParser.dateFormat = "yyyy-MM-dd HH:mm"
        self.hourParser.calendar = calendar
        self.hourParser.timeZone = timeZone
        self.hourParser.locale = Locale(identifier: "en_US_POSIX")
        
        self.dayFormatter = DateFormatter()
        self.dayFormatter.dateFormat = "E"
        self.dayFormatter.calendar = calendar
        self.dayFormatter.timeZone = timeZone
        
        self.hourFormatter = DateFormatter()
        self.hourFormatter.dateFormat = "HH:mm"
        self.hourFormatter.calendar = calendar
        self.hourFormatter.timeZone = timeZone
    }
    
    func parseDay(_ string: String) -> Date? {
        return dayParser.date(from: string)
    }
    
    func parseHour(_ string: String) -> Date? {
        return hourParser.date(from: string)
    }
    
    func formatDay(_ date: Date) -> String {
        return dayFormatter.string(from: date)
    }
    
    func formatHour(_ date: Date) -> String {
        return hourFormatter.string(from: date)
    }
}

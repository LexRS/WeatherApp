//
//  DateParserTests.swift
//  WeatherApp_Test_PowerTests
//
//  Created by Алексей Поддубный on 17.03.2026.
//

import XCTest
@testable import WeatherApp_Test_Power

class DateParserTests: XCTestCase {
    
    var sut: DateParser!
    var fixedCalendar: Calendar!
    var utcTimeZone: TimeZone!
    
    override func setUp() {
        super.setUp()
        // Use a fixed calendar and UTC timezone for consistent tests
        utcTimeZone = TimeZone(secondsFromGMT: 0) ?? .current
        fixedCalendar = .current
        fixedCalendar.timeZone = utcTimeZone
        sut = DateParser(calendar: fixedCalendar, timeZone: utcTimeZone)
    }
    
    override func tearDown() {
        sut = nil
        fixedCalendar = nil
        utcTimeZone = nil
        super.tearDown()
    }
    
    // MARK: - Parse Day Tests
    
    func testParseDay_WithValidDateString_ReturnsDate() {
        // Given
        let dateString = "2024-01-15"
        
        // When
        let result = sut.parseDay(dateString)
        
        // Then
        XCTAssertNotNil(result, "Date should be parsed successfully")
        
        // Verify the date components
        let components = fixedCalendar.dateComponents([.year, .month, .day], from: result!)
        XCTAssertEqual(components.year, 2024)
        XCTAssertEqual(components.month, 1)
        XCTAssertEqual(components.day, 15)
    }
    
    func testParseDay_WithInvalidFormats_ReturnsNil() {
        // Given - Formats that DateFormatter definitely cannot parse
        let invalidStrings = [
            "15-01-2024",      // Day-first format (day-month-year)
            "not a date",      // Complete garbage
            ""                 // Empty string
        ]
        
        for invalidString in invalidStrings {
            let result = sut.parseDay(invalidString)
            XCTAssertNil(result, "Should return nil for: \(invalidString)")
        }
    }
    
    func testParseDay_WithLeapYear_ReturnsCorrectDate() {
        // Given
        let leapDayString = "2024-02-29" // 2024 is leap year
        
        // When
        let result = sut.parseDay(leapDayString)
        
        // Then
        XCTAssertNotNil(result, "Leap day should be parsed")
        let components = fixedCalendar.dateComponents([.month, .day], from: result!)
        XCTAssertEqual(components.month, 2)
        XCTAssertEqual(components.day, 29)
    }
    
    func testParseDay_WithNonLeapYear_ReturnsMarch1st() {
        // Given
        let invalidLeapDayString = "2023-02-29" // 2023 is not leap year
        
        // When
        let result = sut.parseDay(invalidLeapDayString)
        
        // Then
        XCTAssertNotNil(result)
        
        // Should return March 1st, 2023
        let components = Calendar.current.dateComponents([.year, .month, .day], from: result!)
        XCTAssertEqual(components.year, 2023)
        XCTAssertEqual(components.month, 3)  // March
        XCTAssertEqual(components.day, 1)    // 1st
    }
    
    // MARK: - Parse Hour Tests
    
    func testParseHour_WithValidDateTimeString_ReturnsDate() {
        // Given
        let dateTimeString = "2024-01-15 14:30"
        
        // When
        let result = sut.parseHour(dateTimeString)
        
        // Then
        XCTAssertNotNil(result, "DateTime should be parsed successfully")
        
        let components = fixedCalendar.dateComponents([.year, .month, .day, .hour, .minute], from: result!)
        XCTAssertEqual(components.year, 2024)
        XCTAssertEqual(components.month, 1)
        XCTAssertEqual(components.day, 15)
        XCTAssertEqual(components.hour, 14)
        XCTAssertEqual(components.minute, 30)
    }
    
    func testParseHour_WithInvalidHour_ReturnsNil() {
        // Given
        let invalidStrings = [
            "2024-01-15 14:60",  // Invalid minute
            "2024-01-15",        // Missing time
            "2024-01-15 2:30 PM" // Wrong format
        ]
        
        // Then
        for invalidString in invalidStrings {
            let result = sut.parseHour(invalidString)
            XCTAssertNil(result, "Should return nil for: \(invalidString)")
        }
    }
    
    func testParseHour_WithMidnight_ReturnsCorrectDate() {
        // Given
        let midnightString = "2024-01-15 00:00"
        
        // When
        let result = sut.parseHour(midnightString)
        
        // Then
        XCTAssertNotNil(result)
        let components = fixedCalendar.dateComponents([.hour, .minute], from: result!)
        XCTAssertEqual(components.hour, 0)
        XCTAssertEqual(components.minute, 0)
    }
    
    // MARK: - Format Day Tests
    
    func testFormatDay_WithDate_ReturnsDayOfWeek() {
        // Given
        let testCases: [(date: String, expectedDay: String)] = [
            ("2024-01-15", "Mon"), // Monday
            ("2024-01-16", "Tue"), // Tuesday
            ("2024-01-17", "Wed"), // Wednesday
            ("2024-01-18", "Thu"), // Thursday
            ("2024-01-19", "Fri"), // Friday
            ("2024-01-20", "Sat"), // Saturday
            ("2024-01-21", "Sun")  // Sunday
        ]
        
        for testCase in testCases {
            // Given
            guard let date = sut.parseDay(testCase.date) else {
                XCTFail("Failed to parse test date: \(testCase.date)")
                return
            }
            
            // When
            let result = sut.formatDay(date)
            
            // Then
            XCTAssertEqual(result, testCase.expectedDay, "Failed for date: \(testCase.date)")
        }
    }
    
    // MARK: - Format Hour Tests
    
    func testFormatHour_WithDate_ReturnsHourString() {
        // Given
        let testCases: [(dateTime: String, expectedHour: String)] = [
            ("2024-01-15 09:05", "09:05"),
            ("2024-01-15 14:30", "14:30"),
            ("2024-01-15 00:00", "00:00"),
            ("2024-01-15 23:59", "23:59")
        ]
        
        for testCase in testCases {
            // Given
            guard let date = sut.parseHour(testCase.dateTime) else {
                XCTFail("Failed to parse test datetime: \(testCase.dateTime)")
                return
            }
            
            // When
            let result = sut.formatHour(date)
            
            // Then
            XCTAssertEqual(result, testCase.expectedHour, "Failed for datetime: \(testCase.dateTime)")
        }
    }
    
    // MARK: - Edge Cases
    
    func testParseDay_WithBoundaryDates_ReturnsCorrectDates() {
        // Given
        let testCases = [
            "0001-01-01", // Year 1
            "1970-01-01", // Unix epoch
            "2038-01-19", // Y2K38 problem date
            "9999-12-31"  // Max reasonable date
        ]
        
        for dateString in testCases {
            // When
            let result = sut.parseDay(dateString)
            
            // Then
            XCTAssertNotNil(result, "Should parse boundary date: \(dateString)")
        }
    }
    
    func testParseDay_WithLeadingZeros_ReturnsCorrectDate() {
        // Given
        let dateString = "2024-01-01" // January 1st
        
        // When
        let result = sut.parseDay(dateString)
        
        // Then
        XCTAssertNotNil(result)
        let components = fixedCalendar.dateComponents([.month, .day], from: result!)
        XCTAssertEqual(components.month, 1)
        XCTAssertEqual(components.day, 1)
    }
}

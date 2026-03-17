//
//  URL+Ext.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 12.03.2026.
//

import Foundation

extension IconUrlString {
    nonisolated func createImageUrl() -> URL? {
        URL(string: "https:\(self)")
    }
}

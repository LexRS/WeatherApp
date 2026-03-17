//
//  ConditionDTO.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 11.03.2026.
//

import Foundation

typealias IconUrlString = String

struct ConditionDTO: Decodable {
    let text: String
    let icon: IconUrlString
}

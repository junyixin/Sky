//
//  ForecastData.swift
//  Sky
//
//  Created by junyixin on 29/01/2018.
//  Copyright © 2018 junyixin. All rights reserved.
//

import Foundation

struct ForecastData: Codable {
    let time: Date
    let temperatureHigh: Double
    let temperatureLow: Double
    let icon: String
    let humidity: Double
}

extension ForecastData: Equatable {
    static func ==(lhs: ForecastData, rhs: ForecastData) -> Bool {
        return lhs.time == rhs.time &&
            lhs.temperatureHigh == rhs.temperatureHigh &&
            lhs.temperatureLow == rhs.temperatureLow &&
            lhs.icon == rhs.icon &&
            lhs.humidity == rhs.humidity
    }
}

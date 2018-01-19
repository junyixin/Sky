//
//  WeatherData.swift
//  Sky
//
//  Created by junyixin on 19/01/2018.
//  Copyright © 2018 junyixin. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let latitude: Double
    let longitude: Double
    let currently: CurrentWeather
    
    struct CurrentWeather: Codable {
        let time: Date
        let summary: String
        let icon: String
        let temperature: Double
        let humidity: Double
    }
}

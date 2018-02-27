//
//  WeatherDayViewModel.swift
//  Sky
//
//  Created by junyixin on 27/02/2018.
//  Copyright © 2018 junyixin. All rights reserved.
//

import UIKit

struct WeatherDayViewModel {
    let weatherDay: ForecastData
    
    init(_ weatherDay: ForecastData) {
        self.weatherDay = weatherDay
    }
    
    private var dateFormatter = DateFormatter()
    
    var week: String {
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: weatherDay.time)
    }
    
    var date: String {
        dateFormatter.dateFormat = "MMMM d"
        
        return dateFormatter.string(from: weatherDay.time)
    }
    
    var temperature: String {
        let min = format(temperature: weatherDay.temperatureLow)
        let max = format(temperature: weatherDay.temperatureHigh)
        
        return "\(min) ~ \(max)"
    }
    
    var weatherIcon: UIImage? {
        return UIImage.weatherIcon(of: weatherDay.icon)
    }
    
    var humidity: String {
        return String(format: "%.0f %%", weatherDay.humidity)
    }

    /// helpers
    ///
    /// - Parameter temperature: temperature
    /// - Returns: temperature string
    private func format(temperature: Double) -> String {
        switch UserDefaults.temperatureMode() {
        case .celsius:
            return String(format: "%.1f ℃", temperature.toCelcius())
        case .fahrenheit:
            return String(format: "%.1f ℉", temperature)
        }
    }
}

extension WeatherDayViewModel: WeekWeatherDayRepresentable {}

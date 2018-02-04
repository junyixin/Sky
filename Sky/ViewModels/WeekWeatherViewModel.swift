//
//  WeekWeatherViewModel.swift
//  Sky
//
//  Created by junyixin on 29/01/2018.
//  Copyright © 2018 junyixin. All rights reserved.
//

import UIKit

struct WeekWeatherViewModel {
    let weatherData: [ForecastData]
    
    init(_ weatherData: [ForecastData]) {
        self.weatherData = weatherData
    }
    
    private var dateFormatter = DateFormatter()
    
    func week(for index: Int) -> String {
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: weatherData[index].time)
    }
    
    func date(for index: Int) -> String {
        dateFormatter.dateFormat = "MMMM d"
        
        return dateFormatter.string(from: weatherData[index].time)
    }
    
    func temperature(for index: Int) -> String {
        let min = String(format: "%.0f ℃", weatherData[index].temperatureLow.toCelcius())
        let max = String(format: "%.0f ℃", weatherData[index].temperatureHigh.toCelcius())
        
        return "\(min) ~ \(max)"
    }
    
    func weatherIcon(for index: Int) -> UIImage? {
        return UIImage.weatherIcon(of: weatherData[index].icon)
    }
    
    func humidity(for index: Int) -> String {
        return String(format: "%.0f %%", weatherData[index].humidity)
    }
        
    var numberOfSection: Int {
        return 1
    }
    
    var numberOfDays: Int {
        return weatherData.count
    }
}

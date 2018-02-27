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
    
    var numberOfSection: Int {
        return 1
    }
    
    var numberOfDays: Int {
        return weatherData.count
    }
    
    func viewModel(for index: Int) -> WeatherDayViewModel {
        return WeatherDayViewModel(weatherData[index])
    }
}

//
//  WeekWeatherDayRepresentable.swift
//  Sky
//
//  Created by junyixin on 27/02/2018.
//  Copyright © 2018 junyixin. All rights reserved.
//

import UIKit

protocol WeekWeatherDayRepresentable {
    var week: String { get }
    var date: String { get }
    var temperature: String { get }
    var weatherIcon: UIImage? { get }
    var humidity: String { get }
}

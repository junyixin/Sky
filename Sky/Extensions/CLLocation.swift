//
//  CLLocation.swift
//  Sky
//
//  Created by junyixin on 2018/5/29.
//  Copyright © 2018 junyixin. All rights reserved.
//

import CoreLocation

extension CLLocation {
    var toString: String {
        let latitude = String(format: "%.3f", coordinate.latitude)
        let longitude = String(format: "%.3f", coordinate.longitude)
        
        return "\(latitude), \(longitude)"
    }
}

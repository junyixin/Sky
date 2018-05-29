//
//  LocationViewModel.swift
//  Sky
//
//  Created by junyixin on 2018/5/29.
//  Copyright © 2018 junyixin. All rights reserved.
//

import UIKit
import CoreLocation

struct LocationViewModel {
    let location: CLLocation?
    let locationText: String?
}

extension LocationViewModel: LocationRepresentable {
    var labelText: String {
        if let locationText = locationText {
            return locationText
        } else if let location = location {
            return location.toString
        }
        
        return "Unknow postion"
    }
}

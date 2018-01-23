//
//  Double.swift
//  Sky
//
//  Created by junyixin on 23/01/2018.
//  Copyright © 2018 junyixin. All rights reserved.
//

import Foundation

extension Double {
    func toCelcius() -> Double {
        return (self - 32.0) / 1.8
    }
}

//
//  Config.swift
//  Sky
//
//  Created by junyixin on 19/01/2018.
//  Copyright © 2018 junyixin. All rights reserved.
//

import Foundation

struct API {
    static let key = "4deec0c4b3b8bbccef565eb07c4c9694"
    static let baseURL = URL(string: "https://api.darksky.net/forecast/")!
    static let authenticatedURL = baseURL.appendingPathComponent(key)
}

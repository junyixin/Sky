//
//  XCTestCase.swift
//  SkyTests
//
//  Created by junyixin on 2018/5/28.
//  Copyright © 2018 junyixin. All rights reserved.
//

import XCTest

extension XCTestCase {
    func loadDataFromBundle(ofName name: String, ext: String) -> Data {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: name, withExtension: ext)
        
        return try! Data(contentsOf: url!)
    }
}

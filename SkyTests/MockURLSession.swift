//
//  MockURLSession.swift
//  SkyTests
//
//  Created by junyixin on 19/01/2018.
//  Copyright © 2018 junyixin. All rights reserved.
//

import Foundation

@testable import Sky

class MockURLSession: URLSessionProtocol {
    var responseData: Data?
    var responseHeader: HTTPURLResponse?
    var responseError: Error?
    
    var sessionDataTask = MockURLSessionDataTask()
    
    func dataTask(with request: URLRequest, completionHandler: @escaping URLSessionProtocol.dataTaskHandler) -> URLSessionDataTaskProtocol {
        completionHandler(responseData, responseHeader, responseError)
        
        return sessionDataTask
    }
}

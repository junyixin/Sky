//
//  WeatherDataManager.swift
//  Sky
//
//  Created by junyixin on 19/01/2018.
//  Copyright © 2018 junyixin. All rights reserved.
//

import Foundation

enum DataManagerError: Error {
    case failedRequest
    case invalidResponse
    case unknown
}

final class WeatherDataManager {
    internal let baseURL: URL
    internal let urlSession: URLSessionProtocol
    internal init(baseURL: URL, urlSession: URLSessionProtocol) {
        self.baseURL = baseURL
        self.urlSession = urlSession
    }
    
    static let shared = WeatherDataManager(baseURL: API.authenticatedURL, urlSession: URLSession.shared)
    
    typealias CompletionHadler = (WeatherData?, DataManagerError?) -> Void
    
    // 获取天气信息
    func weatherDataAt(latitude: Double, longitude: Double, completion: @escaping CompletionHadler) {
        let url = baseURL.appendingPathComponent("\(latitude), \(longitude)")
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        self.urlSession.dataTask(with: request) { (data, response, error) in
            self.didFinishGettingWeatherData(data: data, response: response, error: error, completion: completion)
        }.resume()
    }
    
    func didFinishGettingWeatherData(data: Data?, response: URLResponse?, error: Error?, completion: CompletionHadler) {
        if let _ = error {
            completion(nil, .failedRequest)
        }
        else if let data = data, let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                // 解析数据
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    let weatherData = try decoder.decode(WeatherData.self, from: data)
                    completion(weatherData, nil)
                }
                catch {
                    completion(nil, .invalidResponse)
                }
            } else {
                completion(nil, .failedRequest)
            }
        }
        else {
            completion(nil, .unknown)
        }
    }
}

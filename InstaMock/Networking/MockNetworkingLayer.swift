//
//  MockNetworkingLayer.swift
//  InstaMock
//
//  Created by Susana on 1/18/21.
//  Copyright © 2021 Susana Meza. All rights reserved.
//

import Foundation

class MockNetworkingLayer {
    
    static let shared = MockNetworkingLayer()
    
    enum NetworkError {
        case noNetworkConnectivity
        case parsingFailure
    }
    
    func getFeed(_ completion: @escaping (Result<FeedResponse, Error>) -> Void ) {
        
        //let internetAvailable = true
        
        if let url = Bundle.main.url(forResource: "FeedPayload", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                let value = try! decoder.decode(FeedResponse.self, from: jsonData)
                completion(.success(value))
            } catch let error {
                // handle error here
                print("Catching error \(error)")
                completion(.failure(error))
            }
        }
        
        
        
    } // func
    
}
extension DateFormatter {
  static let iso8601Full: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
}

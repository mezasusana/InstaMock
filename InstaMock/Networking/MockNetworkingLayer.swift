//
//  MockNetworkingLayer.swift
//  InstaMock
//
//  Created by Susana on 1/18/21.
//  Copyright © 2021 Susana Meza. All rights reserved.
//

import Foundation

class MockNetworkingLayer {
    
    struct DemoConstants {
        static let mockInternetDelay: Double = 0.3 // seconds
        // TODO: no internet connection
    }
    
    static let shared = MockNetworkingLayer()
    
    enum NetworkError {
        case noNetworkConnectivity
        case parsingFailure
    }
    
    func getFeed(_ completion: @escaping (Result<FeedResponse, Error>) -> Void ) {
        
        // Delay the network call on purpose to mock network connection
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + DemoConstants.mockInternetDelay) {
            if let url = Bundle.main.url(forResource: "FeedPayload", withExtension: "json") {
                do {
                    let jsonData = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                    let value = try! decoder.decode(FeedResponse.self, from: jsonData)
                    
                    DispatchQueue.main.async {
                        completion(.success(value))
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }
    }
    
    func changeLikeStatus(to status: Bool, for postId: Int32, _ completion: @escaping (Result<Bool, Error>) -> Void) {
        // Mock send a POST API to change the like status
        DispatchQueue.main.asyncAfter(deadline: .now() + DemoConstants.mockInternetDelay) {
            completion(.success(status))
        }
    }
    
    
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

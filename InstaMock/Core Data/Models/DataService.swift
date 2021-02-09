//
//  DataService.swift
//  InstaMock
//
//  Created by Susana on 2/1/21.
//  Copyright © 2021 Susana Meza. All rights reserved.
//

import Foundation
import UIKit

class DataService {
    
    static let singleton = DataService()
    
    var feedResponse: FeedResponse?
    
    func loadFeedResponse(_ completion: @escaping (Result<FeedResponse, Error>) -> Void) {
        MockNetworkingLayer.shared.getFeed { [weak self] (result) in
            switch result {
            case .success(let feedResponse):
                self?.feedResponse = feedResponse
            case .failure:
                print("Oops, getting feed failed")
            }
            completion(result)
        }
    }
    
    func changeLikeStatus(to status: Bool, for postId: Int32, _ completion: @escaping (Result<Bool, Error>) -> Void) {
        MockNetworkingLayer.shared.changeLikeStatus(to: status, for: postId) { [weak self] (result: Result<Bool, Error>) in
            
            switch result {
            case .success(let verifiedStatus):
                guard
                    let self = self,
                    let changedPost = self.feedItem(for: postId)
                else { return }

                changedPost.likeStatus = verifiedStatus
            default: break
            }
            
            completion(result)
        }
    }
    
    func feedItem(for postId: Int32) -> FeedItem? {
        feedResponse?.feedItems.first(where: { feedItem -> Bool in
            return feedItem.postId == postId
        })
    }
    

    
    

}

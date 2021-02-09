//
//  FeedViewModel.swift
//  InstaMock
//
//  Created by Susana on 1/18/21.
//  Copyright © 2021 Susana Meza. All rights reserved.
//

import Foundation

class FeedViewModel {
    
    var likeDebouncer = Debouncer(seconds: 3.0)
    
    
    // MARK: Public API
    
    var numberOfRows: Int {
        DataService.singleton.feedResponse?.feedItems.count ?? 5
    }
    
    func feedItem(_ forIndexPath: IndexPath) -> FeedItem? {
        guard
            let feedResponse = DataService.singleton.feedResponse,
            feedResponse.feedItems.count > forIndexPath.row
        else {
            return nil
        }
        
        return feedResponse.feedItems[forIndexPath.row]
    }
    
    func loadFeedResponse(_ completion: @escaping (Result<FeedResponse, Error>) -> Void) { 
        DataService.singleton.loadFeedResponse(completion)
    }
    
    func changeLikeStatus(to status: Bool, for postId: Int32, _ completion: @escaping (Result<Bool, Error>) -> Void) {
        likeDebouncer.debounce {
            DataService.singleton.changeLikeStatus(to: status, for: postId, completion)
        }
    }
    
    
}

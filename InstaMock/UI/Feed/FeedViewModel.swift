//
//  FeedViewModel.swift
//  InstaMock
//
//  Created by Susana on 1/18/21.
//  Copyright © 2021 Susana Meza. All rights reserved.
//

import Foundation

class FeedViewModel {
    
    var feedResponse: FeedResponse?
    
    // MARK: Public API
    
    var numberOfRows: Int {
        // TODO:
        5
    }
    
    func feedItem(_ forIndexPath: IndexPath) -> FeedItem? {
        guard
            let feedResponse = feedResponse,
            feedResponse.feedItems.count > forIndexPath.row
        else {
            return nil
        }
        return feedResponse.feedItems[forIndexPath.row]
    }
    
    func loadFeedResponse() {
        MockNetworkingLayer.shared.getFeed { [weak self] (result) in
            switch result {
            case .success(let feedResponse):
                self?.feedResponse = feedResponse
            case .failure(let _):
                print("Oops, getting feed failed")
            }
        }
    }

    
}

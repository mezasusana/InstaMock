//
//  FeedViewModel.swift
//  InstaMock
//
//  Created by Susana on 1/18/21.
//  Copyright © 2021 Susana Meza. All rights reserved.
//

import Foundation

class FeedViewModel {
    
    // MARK: Public API
    
    var numberOfRows: Int {
        // TODO:
        5
    }
    
    func feedItem(_ for: IndexPath) -> FeedItem? {
        return generateMockFeedItem()
    }
    
    
    // MARK: Delete This (TEMP)
    
    private func generateMockFeedItem() -> FeedItem {
        return FeedItem(userImageId: 123,
                        displayName: "Susana Meza",
                        followStatus: false,
                        postImageId: 456,
                        likeStatus: false,
                        likeCount: 1723898,
                        comment: "Hi!",
                        subCommentCount: 70,
                        date: Date())
        
    }
    
}

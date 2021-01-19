//
//  FeedItem.swift
//  InstaMock
//
//  Created by Susana on 1/18/21.
//  Copyright © 2021 Susana Meza. All rights reserved.
//

import Foundation

struct FeedResponse: Codable {
    var feedItems: [FeedItem]
    

}

struct FeedItem: Codable {
    var userImageId: Int32
    var displayName: String
    var followStatus: Bool
    var postImageId: Int32
    var likeStatus: Bool
    var likeCount: Int32
    var comment: String
    var subCommentCount: Int32
    var date: Date

}

//
//  FeedItem.swift
//  InstaMock
//
//  Created by Susana on 1/18/21.
//  Copyright © 2021 Susana Meza. All rights reserved.
//

import Foundation

// Note: For the purpose of this demo, these objects are classes

class FeedResponse: Codable {
    var feedItems: [FeedItem]
    

}

class FeedItem: Codable {
    var userImageId: Int32
    var displayName: String
    var followStatus: Bool
    var postId: Int32
    var likeStatus: Bool
    var likeCount: Int32
    var commentItems: [CommentItem]
    var subCommentCount: Int32
    var date: Date

}

class CommentItem: Codable {
let username: String
let comment: String
}

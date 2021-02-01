//
//  CommentsTableViewCell.swift
//  InstaMock
//
//  Created by Susana on 1/31/21.
//  Copyright © 2021 Susana Meza. All rights reserved.
//

import Foundation
import UIKit

protocol CommentsTableViewCellDelegate: AnyObject {
    func likeButtonTapped()
}

class CommentsTableViewCell: UITableViewCell {
    
    static var commentsCellIdentifier: String {
        return "CommentsTableViewCell"
    }
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var commentUsername: UIButton!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentDate: UILabel!
    @IBOutlet weak var commentLikeCount: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var likeCommentButton: UIButton!
    
    weak var commentsTableViewCellDelegate: CommentsTableViewCellDelegate?
    
    //TODO: fix do not store here
    var isLiked = false
    var numLikes = 0
    
    @IBAction func likeCommentButton(_ sender: UIButton) {
        isLiked = !isLiked
        if isLiked {
            sender.setImage(UIImage.init(systemName: "heart.fill"), for: .normal)
            numLikes = numLikes + 1
            if numLikes == 1 {
                commentLikeCount.text = "\(self.numLikes) like"
            } else {
                commentLikeCount.text = "\(self.numLikes) likes"
            }
        } else {
            sender.setImage(UIImage.init(systemName: "heart"), for: .normal)
            numLikes = numLikes - 1
            if numLikes == 1 {
                commentLikeCount.text = "\(self.numLikes) like"
            } else {
                commentLikeCount.text = "\(self.numLikes) likes"
            }
        }
    }
    
    func configure(with commentItem: CommentItem, delegate: CommentsTableViewCellDelegate?){
        commentUsername.setTitle(commentItem.username, for: .normal)
        commentLabel.text = (commentItem.comment)
        profilePicture.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        profilePicture.setRounded()
        commentsTableViewCellDelegate = delegate
    }
    //func configure(with feedItem: FeedItem, delegate: FeedTableViewCellDelegate?)
    
}

//
//  FeedTableViewCell.swift
//  InstaMock
//
//  Created by Susana on 1/18/21.
//  Copyright © 2021 Susana Meza. All rights reserved.
//

import Foundation
import UIKit

protocol FeedTableViewCellDelegate: AnyObject {
    func viewCommentsButtonTapped(cell: FeedTableViewCell)
}

class FeedTableViewCell: UITableViewCell {
    
    static var identifier: String {
        return "FeedTableViewCell"
    }
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileUsername: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var viewCommentsButton: UIButton!
    @IBOutlet weak var commentsSection: UILabel!
    @IBOutlet weak var datePosted: UILabel!
    
    weak var feedTableViewCellDelegate: FeedTableViewCellDelegate?
    
    //TODO: fix do not store here
    var isFollowing = false
    var isLiked = false
    var numLikes = 0
    
    @IBAction func followButton(_ sender: UIButton) {
        isFollowing = !isFollowing
        if isFollowing {
            sender.setTitle("Following", for: .normal)
            sender.setTitleColor(.black, for: .normal)
        } else {
            sender.setTitle("Follow", for: .normal)
            sender.setTitleColor(.link, for: .normal)
        }
    }
    
    @IBAction func likeButton(_ sender: UIButton) {
        isLiked = !isLiked
        if isLiked {
            sender.setImage(UIImage.init(systemName: "heart.fill"), for: .normal)
            numLikes = numLikes + 1
            if numLikes == 1 {
                likeCount.text = "\(self.numLikes) like"
            } else {
                likeCount.text = "\(self.numLikes) likes"
            }

        } else {
            sender.setImage(UIImage.init(systemName: "heart"), for: .normal)
            numLikes = numLikes - 1
            if numLikes == 1 {
                likeCount.text = "\(self.numLikes) like"
            } else {
                likeCount.text = "\(self.numLikes) likes"
            }
        }
    }
    
    @IBAction func viewCommentsButton(_ sender: UIButton) {
        feedTableViewCellDelegate?.viewCommentsButtonTapped(cell: self)
    }
    
    
    func configure(with feedItem: FeedItem, delegate: FeedTableViewCellDelegate?) {
        profileUsername.text = feedItem.displayName
        commentsSection.isHidden = true
        likeCount.text = "\(String(feedItem.likeCount)) likes"
        profileImage.image = UIImage(named: String(feedItem.userImageId))
        profileImage.setRounded()
        postImage.image = UIImage(named: String(feedItem.postImageId))
        viewCommentsButton.setTitle("View \(String(feedItem.subCommentCount)) comments", for: .normal)
        datePosted.text = String(feedItem.date.getElapsedInterval())
        feedTableViewCellDelegate = delegate
    }
}

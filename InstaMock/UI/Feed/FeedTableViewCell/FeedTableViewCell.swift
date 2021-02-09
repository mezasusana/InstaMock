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
    func likeButtonTapped(cell: FeedTableViewCell, changeLikeStatusTo: Bool)
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
    weak var viewModel: FeedViewModel?
    
    var likeStatus: Bool = false

    @IBAction func followButton(_ sender: UIButton) {
        
    }
    
    @IBAction func likeButton(_ sender: UIButton) {
        if likeStatus {
            self.unlike()
        } else {
            self.like()
        }
        feedTableViewCellDelegate?.likeButtonTapped(cell: self, changeLikeStatusTo: likeStatus)
    }
    
    @IBAction func viewCommentsButton(_ sender: UIButton) {
        feedTableViewCellDelegate?.viewCommentsButtonTapped(cell: self)
    }
    
    
    func configure(with feedItem: FeedItem, delegate: FeedTableViewCellDelegate?) {
        profileUsername.text = feedItem.displayName
        commentsSection.isHidden = true
        profileImage.image = UIImage(named: String(feedItem.userImageId))
        profileImage.setRounded()
        postImage.image = UIImage(named: String(feedItem.postId))
        viewCommentsButton.setTitle("View \(String(feedItem.subCommentCount)) comments", for: .normal)
        datePosted.text = String(feedItem.date.getElapsedInterval())
        likeCount.text = "\(String(feedItem.likeCount)) likes"
        
        if feedItem.likeStatus {
            like()
            likeStatus = true
        } else {
            unlike()
            likeStatus = false
        }
        
        if feedItem.followStatus {
            followButton.setTitle("Following", for: .normal)
            followButton.setTitleColor(.darkGray, for: .normal)
        } else {
            followButton.setTitle("Follow", for: .normal)
            followButton.setTitleColor(.link, for: .normal)
            
        }
        
        feedTableViewCellDelegate = delegate
    }
    
    func unlike() {
        likeStatus = false
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }

    func like() {
        likeStatus = true
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }
    
}

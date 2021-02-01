//
//  CommentsViewController.swift
//  InstaMock
//
//  Created by Susana on 1/18/21.
//  Copyright © 2021 Susana Meza. All rights reserved.
//

import Foundation
import UIKit

class CommentsViewController: UIViewController {
    
    var commentsTableView = UITableView()
    var commentsViewModel: CommentsViewModel
    
    init() {
        commentsViewModel = CommentsViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        registerCommentsCell()
        self.navigationItem.title = "Comments"
    }
    
    func setup(with commentItems: [CommentItem]) {
        commentsViewModel.commentItems = commentItems
    }
    
    func configureTableView() {
        view.addSubview(commentsTableView)
        
        commentsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
           commentsTableView.topAnchor.constraint(equalTo: view.topAnchor),
           commentsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
           commentsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
           commentsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        commentsTableView.dataSource = self
        commentsTableView.delegate = self

    }
    
    private func registerCommentsCell() {
        let commentsCell = UINib(nibName: "CommentsTableViewCell", bundle: nil)
        commentsTableView.register(commentsCell, forCellReuseIdentifier: "CommentsTableViewCell")
    }


}

extension CommentsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        commentsViewModel.commentItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let commentCell = tableView.dequeueReusableCell(withIdentifier: "CommentsTableViewCell", for: indexPath) as? CommentsTableViewCell,
            let commentItem = commentsViewModel.commentItem(at: indexPath.row)
            else {
                return UITableViewCell()
        }
        
        commentCell.configure(with: commentItem, delegate: self)
        return commentCell
    }
}

extension CommentsViewController: UITableViewDelegate {
    
}

extension CommentsViewController: CommentsTableViewCellDelegate {
    func likeButtonTapped() {
        print("comment liked")
    }
    
    
}

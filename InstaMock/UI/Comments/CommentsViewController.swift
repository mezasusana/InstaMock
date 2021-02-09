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
        configureFooter()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
    func configureFooter() {
        let textField = UITextField(frame: CGRect(x:20, y: (view.frame.height - 60) , width: view.frame.width - 40, height: 50))
        textField.borderStyle = .roundedRect
        textField.placeholder = "Add Comment"
        textField.textColor = UIColor.black
        
        let button = UIButton(frame: CGRect(x: view.frame.width - 65 , y: (view.frame.height - 60) , width: 50, height: 50))
        button.setImage(UIImage.init(systemName: "paperplane.fill" ), for: .normal)

        self.view.addSubview(textField)
        self.view.addSubview(button)
 
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
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

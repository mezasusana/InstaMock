//
//  FeedViewController.swift
//  InstaMock
//
//  Created by Susana on 1/18/21.
//  Copyright © 2021 Susana Meza. All rights reserved.
//

import UIKit
import Foundation

class FeedViewController: UIViewController {
    
    var tableView: UITableView
    var viewModel: FeedViewModel
    var dataService: DataService
    
    // MARK: LifeCycle
    
    init() {
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        viewModel = FeedViewModel()
        dataService = DataService()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        registerCells()
        loadData()
    }
    
    // MARK: Setup
    
    private func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        view.addConstraints([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
         ])
    }
    
    private func registerCells() {
        let cell = UINib(nibName: "FeedTableViewCell", bundle: nil)
        self.tableView.register(cell, forCellReuseIdentifier: "FeedTableViewCell")
        
    }
    
    private func loadData() {
        viewModel.loadFeedResponse { [weak self] (result: Result<FeedResponse, Error>) in
            guard let self = self else { return }

            switch result {
            case .success:
                self.tableView.reloadData()
            case .failure:
                print("Oops. no internet connection")// TODO: show an error here.. (no internet)
            }
        }
    }
    
    private func presentErrorAlert() {
        // TODO: Present an error when we don't "have" intenet connection
    }

}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as? FeedTableViewCell,
            let feedItem = viewModel.feedItem(indexPath)
        else {
            return UITableViewCell()
        }
        cell.configure(with: feedItem, delegate: self)
        return cell
    }
    
    
}

extension FeedViewController: UITableViewDelegate {
    
}

extension FeedViewController: FeedTableViewCellDelegate {

    func viewCommentsButtonTapped(cell: FeedTableViewCell) {
        guard
            let indexPath = tableView.indexPath(for: cell),
            let feedItem = viewModel.feedItem(indexPath)
        else {
            return
        }
        
        let commentItems = feedItem.commentItems
        let commentViewController = CommentsViewController()
        commentViewController.setup(with: commentItems)
        self.navigationController?.pushViewController(commentViewController, animated: true)
    }
    
    func likeButtonTapped(cell: FeedTableViewCell, changeLikeStatusTo likeStatus: Bool) {
        guard
            let indexPath = tableView.indexPath(for: cell),
            let feedItem = viewModel.feedItem(indexPath)
        else {
            return
        }
        let postID = feedItem.postId
        
        viewModel.changeLikeStatus(to: likeStatus, for: postID) { [weak self] status in
            
            guard
                let self = self,
                self.tableView.indexPathsForVisibleRows?.contains(indexPath) ?? false,
                let cell = self.tableView.cellForRow(at: indexPath) as? FeedTableViewCell
            else {
                return
            }
            
            switch status {
            case .success(let newLikeStatus):
                if newLikeStatus {
                    cell.like()
                } else {
                    cell.unlike()
                }
            case .failure: // TODO: No internet connection error
                self.presentErrorAlert()
            }
        }
    }


}



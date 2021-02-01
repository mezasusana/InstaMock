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
    
    // MARK: LifeCycle
    
    init() {
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        viewModel = FeedViewModel()
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
        viewModel.loadFeedResponse()
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
}


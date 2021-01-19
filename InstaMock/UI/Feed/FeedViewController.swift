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
    
    var feedTableView: UITableView
    var feedViewModel: FeedViewModel
    
    // MARK: LifeCycle
    
    init() {
        feedTableView = UITableView(frame: CGRect.zero, style: .plain)
        feedViewModel = FeedViewModel()
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
        feedTableView.dataSource = self
        feedTableView.delegate = self

        feedTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(feedTableView)
        view.addConstraints([
            feedTableView.topAnchor.constraint(equalTo: view.topAnchor),
            feedTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            feedTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            feedTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
         ])
    }
    
    private func registerCells() {
        feedTableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.identifier)
        
    }
    
    private func loadData() {
        feedViewModel.loadFeedResponse()
    }

}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        feedViewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as? FeedTableViewCell,
            let feedItem = feedViewModel.feedItem(indexPath)
        else {
            return UITableViewCell()
        }
        
        cell.configure(feedItem)
        
        return cell
    }
    
    
}

extension FeedViewController: UITableViewDelegate {
    
}

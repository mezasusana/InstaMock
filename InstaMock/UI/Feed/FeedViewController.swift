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
    
    var feedViewModel: FeedViewModel
    
    // MARK: LifeCycle
    
    init() {
        feedViewModel = FeedViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

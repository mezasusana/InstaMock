//
//  InitialViewController.swift
//  InstaMock
//
//  Created by Susana on 2/10/21.
//  Copyright © 2021 Susana Meza. All rights reserved.
//

import Foundation
import UIKit

class InitialViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        let signUpViewController = SignUpViewController()
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let loginViewController = LoginViewController()
        self.navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    func setUp() {
        Style.styleHollowButton(signUpButton)
        Style.styleFilledButton(logInButton)
    }
 
    
}

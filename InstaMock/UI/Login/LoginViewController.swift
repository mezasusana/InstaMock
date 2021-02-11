//
//  Log In View Controller.swift
//  InstaMock
//
//  Created by Susana on 2/10/21.
//  Copyright © 2021 Susana Meza. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseAuth

class LoginViewController: UIViewController  {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        let error = validateFields()
        
        if error != nil{
            showError(error!)
        }
            
        else {
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil{
                    self.errorLabel.text = error!.localizedDescription
                    self.errorLabel.alpha = 1
                } else {
                    let feedViewController = FeedViewController()
                    self.navigationController?.pushViewController(feedViewController, animated: true)
                }
            }
            
        }

    }
    
    func setUp() {
        errorLabel.alpha = 0
        Style.styleFilledButton(loginButton)
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func validateFields() -> String? {
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
        
            return "Please review and fill in all fields"
        }
        
        let validPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Style.passwordIsValid(validPassword) == false {
            return "Please make sure your password contains a special character, number, and is at least 8 characters"
        }
        
        return nil
        
    }
    
}


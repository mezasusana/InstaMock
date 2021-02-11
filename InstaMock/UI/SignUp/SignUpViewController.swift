//
//  SignUpViewController.swift
//  InstaMock
//
//  Created by Susana on 2/10/21.
//  Copyright © 2021 Susana Meza. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore


class SignUpViewController: UIViewController  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        

    }
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        let error = validateFields()
        
        if error != nil{
            showError(error!)
        }
            
        else {
            
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                
                if error != nil {
                    self.showError("Error creating user")
                }
                else {
                    let db = Firestore.firestore()
                    db.collection("Users").addDocument(data: ["firstname": firstName, "lastname": lastName, "userID": result!.user.uid]) { (error) in
                        if error != nil {
                            self.showError("Sorry, user data couldn't be saved")
                        }
                    }
                    let feedViewController = FeedViewController()
                    self.navigationController?.pushViewController(feedViewController, animated: true)
                }
            }
        }
        
        
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func setUp() {
        errorLabel.alpha = 0
        Style.styleFilledButton(signUpButton)
    }
    
    func validateFields() -> String? {
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
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

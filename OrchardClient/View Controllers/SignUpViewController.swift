//
//  SignUpViewController.swift
//  OrchardClient
//
//  Created by Matthew Harrilal on 10/26/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
    //    MARK: UIElements
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let networkingInstance = LogInNetworkingLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        let user = User(email: emailTextField.text, password: passwordTextField.text)
        networkingInstance.network(route: .users(), user: user, requestRoute: .post) { (data, response) in
            
        }
    }
    
}

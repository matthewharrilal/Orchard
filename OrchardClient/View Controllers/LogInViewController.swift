//
//  ViewController.swift
//  OrchardClient
//
//  Created by Matthew Harrilal on 10/21/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    //MARK: UIElements
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    let defaults = UserDefaults.standard
    
    let networkingInstance = LogInNetworkingLayer()
    let alertInstance = Alert()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logInButton(_ sender: Any) {
        let user = User(email: emailTextField.text!, password: passwordTextField.text!)
        networkingInstance.network(route: Route.users(), user: user, requestRoute: .get) { (data, responseInt) in
            if responseInt == 200 {
                print("The user was succesfully logged in")
                self.defaults.set(true, forKey: "LoggedIn")
                if let customerTokenData = self.defaults.data(forKey: "SignedUp") {
                    let customerToken = NSKeyedUnarchiver.unarchiveObject(with: customerTokenData) as! User
                    print("This is the users token \(customerToken)")
                }
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "showUsers", sender: nil)
                }
            }
            else {
                print("The user can not be logged in")
                DispatchQueue.main.async {
                    self.alertInstance.logInAlert(controller: self)
                }
            }
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController")
        self.navigationController?.pushViewController(controller!, animated: true)
    }
    
}

//
//  DisplayGithubUsers.swift
//  OrchardClient
//
//  Created by Matthew Harrilal on 10/24/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class FindGithubUsers: UIViewController {
    let networkingInstance = GithubNetworkingLayer()
    
    @IBOutlet weak var findUserTextField: UITextField!
    
    var usersArray = [GithubUser]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func findUserButton(_ sender: Any) {
        guard let user = findUserTextField.text else {return}

        let displayUsers = DisplayGithubUsers()
        displayUsers.username = user
        
        networkingInstance.network(route: .users(username: findUserTextField.text!), requestRoute: .get) { (data, response) in
            let newUsers = try? JSONDecoder().decode(GithubUserArray.self, from: data)
            guard let users1 = newUsers?.items else{return}
            displayUsers.usersArray = users1
            
        }
        self.performSegue(withIdentifier: "displayGithubUser", sender: nil)
    }
}

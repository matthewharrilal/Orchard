//
//  DisplayGithubUsers.swift
//  OrchardClient
//
//  Created by Matthew Harrilal on 10/24/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class DisplayGithubUsers: UIViewController {
    let networkingInstance = GithubNetworkingLayer()
    
    @IBOutlet weak var findUserTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func findUserButton(_ sender: Any) {
        networkingInstance.network(route: .users(), requestRoute: .get) { (data, response) in
            let users = try? JSONDecoder().decode(GithubUser.self, from: data)
            guard let newUser = users?.email else{return}
            print(newUser)
            
        }
    }
}

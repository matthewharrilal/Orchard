//
//  DisplayUserRepositories.swift
//  OrchardClient
//
//  Created by Matthew Harrilal on 11/22/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class DisplayUserRepositories: UITableViewController {
    var usernameText = ""
    
    var repositories1 = [UserGithubRepositories]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    let userRepositoriesInstance = UserRepositoriesNetworkingLayer()
    
    var displayInstance = DisplayGithubUsers()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("This is the username text when displaying the repos \(self.usernameText)")
        FindUsersName.username = self.usernameText
        userRepositoriesInstance.network(route: .users(), requestRoute: .get) { (data) in
            
            guard let repos = try? JSONDecoder().decode([UserGithubRepositories].self, from: data) else {return}
            print("These are the repos \(repos)")
            self.repositories1 = repos
        }
      
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return repositories1.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let repos = repositories1[indexPath.row]
        cell.textLabel?.text = repos.name

        return cell
    }
}

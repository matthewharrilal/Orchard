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
    var usernameText1 = ""
    
    var repositories1 = [UserGithubRepositories]()
    
    let userRepositoriesInstance = UserRepositoriesNetworkingLayer()
    
    var displayInstance = DisplayGithubUsers()
    
    var commitsArray: [Int] = [Int]()
    
    func swipeToLogin() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        FindUsersName.username = self.usernameText
        userRepositoriesInstance.network(route: .users(), requestRoute: .get) { (data) in
            
            let repos = try? JSONDecoder().decode([UserGithubRepositories].self, from: data)
            self.repositories1 = repos!
            print("These are the repos \(self.repositories1)")
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories1.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let repos = repositories1[indexPath.row]
        cell.textLabel?.text = repos.name
        self.usernameText = (cell.textLabel?.text)!
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "graphUserCommits" {
                let graphViewControllerVC = segue.destination as! GraphViewController
                guard let indexPath = tableView.indexPathForSelectedRow else {return}
                let userRepo = self.repositories1[indexPath.row]
                graphViewControllerVC.userRepoName = userRepo.name
                
            }
        }
    }
}

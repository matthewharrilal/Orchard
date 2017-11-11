//
//  DisplayGithubUsers.swift
//  OrchardClient
//
//  Created by Matthew Harrilal on 11/6/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import Zip

class DisplayGithubUsers: UITableViewController {
    
    let githubNetworkInstance = GithubNetworkingLayer()
    let downloadProfileImageInstance = DownloadProfileImage()
    
    
    var usernameText = ""
    var usersArray = [GithubUser]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        githubNetworkInstance.network(route: .users(username: usernameText), requestRoute: .get) { (data, response) in
            print(self.usernameText)
            let user = try? JSONDecoder().decode(GithubUserArray.self, from: data)
            guard let userName = user?.items else {return}
            self.usersArray = userName
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DisplayUsersTableViewCell
        let user = usersArray[indexPath.row]
        cell.userLoginLabel.text = user.login
        cell.detailTextLabel?.text = user.avatarUrl
        cell.displayUsersImageView.contentMode = .scaleAspectFit
        let url = URL(string: user.avatarUrl!)
        if url != nil {
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.displayUsersImageView.image = UIImage(data: data)
                        
                        //                        self.tableView.reloadData()
                    }
                    
                } else {
                    DispatchQueue.main.async {
                        cell.imageView?.image = UIImage(named: "noImage.png")
                    }
                }
            }).resume()
        }
        
        return cell
    }
}

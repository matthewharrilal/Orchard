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
    
    
    var username = "matthew"
    var usersArray = [GithubUser]()
    
    
    func getImage() ->URL{
        let caches = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0])
        var cacheURL = URL(fileURLWithPath: caches)
        self.downloadProfileImageInstance.downloadProfileImage(httpMethod: .get) { (url) in
            
            cacheURL.appendPathComponent("tmp")
            let directory = try? FileManager.default.moveItem(at: url!, to: cacheURL)
        }
        print("This is the cache url \(cacheURL)")
        return cacheURL
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        githubNetworkInstance.network(route: .users(username: "matthewharrilal" ), requestRoute: .get) { (data, response) in
            let user = try? JSONDecoder().decode(GithubUserArray.self, from: data)
            guard let userName = user?.items else {return}
            self.usersArray = userName
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        getImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let userEmail = usersEmail[indexPath.row]
//        let userLogin = usersLogin[indexPath.row]
//        let profileImage = usersProfileImage[indexPath.row]
        let user = usersArray[indexPath.row]
        cell.textLabel?.text = user.login
        cell.detailTextLabel?.text = user.email
        let url = URL(string: user.avatarUrl!)
        if url != nil {
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.imageView?.image = UIImage(data: data)
                        self.tableView.reloadData()
                    }
                }
            }).resume()
        }
        
        return cell
    }
}

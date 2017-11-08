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
    
    
    var usersEmail = [String]()
    var usersLogin = [String]()
    var usersProfileImage = [String]()
    
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
        githubNetworkInstance.network(route: .users(), requestRoute: .get) { (data, response) in
            let user = try? JSONDecoder().decode(GithubUser.self, from: data)
            self.usersEmail.append((user?.email)!)
            self.usersLogin.append((user?.login)!)
            self.usersProfileImage.append((user?.avatarUrl)!)
            
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
        return usersLogin.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let userEmail = usersEmail[indexPath.row]
        let userLogin = usersLogin[indexPath.row]
        cell.textLabel?.text = userLogin
        cell.detailTextLabel?.text = userEmail
        
        let contentsOfDirectory = try? FileManager.default.contentsOfDirectory(at: getImage() , includingPropertiesForKeys: [], options: .skipsHiddenFiles)[2]

        if contentsOfDirectory != nil {
        let imageData = try? Data(contentsOf: contentsOfDirectory!)

            cell.imageView?.image = UIImage(data: imageData!)
//            self.tableView.reloadData()
        
        }
        return cell
    }
}

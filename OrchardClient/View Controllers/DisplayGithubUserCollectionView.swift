//
//  DisplayGithubUserCollectionView.swift
//  OrchardClient
//
//  Created by Matthew Harrilal on 11/9/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class DisplayGithubUserCollectionView: UICollectionViewController {
    
    let githubNetworkingInstance = GithubNetworkingLayer()
    var usernameText = ""
    
    var usersArray = [GithubUser]() 
      
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        githubNetworkingInstance.network(route: .users(username: usernameText), requestRoute: .get) { (data, response) in
            let user = try? JSONDecoder().decode(GithubUserArray.self, from: data)
            guard let username = user?.items else {return}
            self.usersArray = username
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usersArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DisplayGithubUserCollectionViewCell
        let user = usersArray[indexPath.row]
        cell.userLoginLabel.text = user.login
        let url = URL(string: user.avatarUrl!)
        if url != nil {
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.githubUserImageVIew.image = UIImage(data: data)
                    }
                }
            }).resume()
        }
        return cell
        
    }
}

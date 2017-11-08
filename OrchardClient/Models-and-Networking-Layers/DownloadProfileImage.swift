//
//  File.swift
//  OrchardClient
//
//  Created by Matthew Harrilal on 11/6/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import Zip

struct ImageLink {
    static var imageLink = ""
}

enum HttpMethods: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

class DownloadProfileImage {
    
    var session = URLSession.shared
    
    let githubUserInstance = GithubNetworkingLayer()
    
    func downloadProfileImage(httpMethod: HttpMethods, completionHandler: @escaping (URL?) -> Void) {
        
        githubUserInstance.network(route: .users(username: "matthewharrilal"), requestRoute: .get) { (data, response) in
            var user = try? JSONDecoder().decode(GithubUser.self, from: data)
            print(user?.avatarUrl)
            ImageLink.imageLink = (user?.avatarUrl)!
            //            self.profileImageUrl = ImageLink.imageLink
            
            self.session.downloadTask(with: URLRequest(url: URL(string: "https://avatars3.githubusercontent.com/u/10717020?v=4")!)) { (url, response, error) in
                if let url = url {
                    completionHandler(url)
                }
                }.resume()
        }
        
        
    }
}


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

enum HttpMethods: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

class DownloadProfileImage {
    
    var profileImageUrl: String?
    
    var session = URLSession.shared
    
    let githubUserInstance = GithubNetworkingLayer()
    
    func downloadProfileImage(httpMethod: HttpMethods, completionHandler: @escaping (URL?) -> Void) {
        
        githubUserInstance.network(route: .users(), requestRoute: .get) { (data, response) in
            var user = try? JSONDecoder().decode(GithubUser.self, from: data)
            user?.avatarUrl = self.profileImageUrl
        }
        self.session.downloadTask(with: URLRequest(url: URL(string: profileImageUrl!)!)) { (url, response, error) in
            if let url = url {
                completionHandler(url)
            }
        }.resume()
    }
}


//
//  GithubCommitsNetworkingLayer.swift
//  OrchardClient
//
//  Created by Matthew Harrilal on 12/2/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

let githubUser = DisplayGithubUsers()

struct RepositoryName {
    static var repositoryName = ""
}

enum CommitRoutes {
    case user(repositoryName: String)
    
    func path() -> String {
        switch self {
        case .user:
            return "/repos/\(githubUser.usernameText)/\(RepositoryName.repositoryName)"
        }
    }
    
}

class GithubCommitsNetworkingLayer {
    var baseURL = "https://api.github.com"
    
    func network(route: GithubRoutes, requestRoute: DifferentHttpMethods, completionHandler: @escaping (Data) -> Void) {
        var fullUrlString = URL(string: baseURL.appending(route.path()))
        var getRequest = URLRequest(url: fullUrlString!)
        getRequest.httpMethod = requestRoute.rawValue
        getRequest.allHTTPHeaderFields = route.urlHeaders()
        session.dataTask(with: getRequest) { (data, response, error) in
            if let data = data {
                completionHandler(data)
            }
        }.resume()
    }
}

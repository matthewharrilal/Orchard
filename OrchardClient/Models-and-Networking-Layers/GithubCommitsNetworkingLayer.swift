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
    static var username = ""
}

enum CommitRoutes {
    case user()
    
    func path() -> String {
        switch self {
        case .user:
            print("The username text from the display Instance is \(RepositoryName.username), \(RepositoryName.repositoryName)")
            return "/repos/\(RepositoryName.username)/\(RepositoryName.repositoryName)/commits"
        }
    }
    
    func urlHeaders() -> [String: String] {
        var urlHeaders = ["Authorization": OauthToken.githubToken]
        return urlHeaders
    }
}

class GithubCommitsNetworkingLayer {
    var baseURL = "https://api.github.com"
    
    func network(route: CommitRoutes, requestRoute: DifferentHttpMethods, completionHandler: @escaping (Data) -> Void) {
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

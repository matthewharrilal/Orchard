//
//  UserRepositoriesNetworkingLayer.swift
//  OrchardClient
//
//  Created by Matthew Harrilal on 11/22/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit



struct FindUsersName {
    // The ability to keep the name at which the user taps on the cell dynamic to view the users github repositories
    static var username = ""
}


enum FindingUserRepositoriesRoute {
    // The different cases that can occur
    case users()
    
    // The path the user can take when executing the network request
    func path() -> String {
        switch self {
            
        // If the user chooses the user pathway the url or the pathway would be constructed in this fashiom
        case .users:
            return "users/\(FindUsersName.username)/repos"
        }
    }
    
    // The headers that go into making the network requst need the authentication token to be able to gain access to the data
    func urlHeaders() -> [String: String] {
        var urlHeaders = ["Authorization": OauthToken.githubToken]
        return urlHeaders
    }
    
}

class UserRepositoriesNetworkingLayer {
    
    // The base url at which the network tasks are performed
    var baseUrl = "https://api.github.com"
    
    // The function that takes care of our network requests handling factoras such as the different route pathways the user can take as well as the request route such as different http methods on the internet task that can be performed as well as the completion handler because the data can be returned to us at a later time
    func network(route: FindingUserRepositoriesRoute, requestRoute: DifferentHttpMethods, completionHandler: @escaping (Data) -> Void) {
        guard let fullUrlString = URL(string: baseUrl.appending(route.path())) else{return}
        var getRequest = URLRequest(url: fullUrlString)
        getRequest.allHTTPHeaderFields = route.urlHeaders()
        session.dataTask(with: getRequest) { (data, response, error) in
            if let data = data {
                completionHandler(data)
            }
            }.resume()
        
    }
}



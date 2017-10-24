//
//  GithubUser.swift
//  OrchardClient
//
//  Created by Matthew Harrilal on 10/23/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

let session = URLSession.shared

enum GithubRoutes {
    case users()
    
    func path() -> String {
//       This represents the possible routes the user can take when verified and is querying the github api
        switch self {
        case .users():
            return "/users"
        }
    }
    
    func urlParameters(username: String? = nil) -> [String: String] {
        switch self {
        case .users():
            let userParameters = ["users": String(describing: username)]
            return userParameters
        }
    }
}

enum DifferentHttpMethods: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
    case patch = "PATCH"
}

class GithubNetworkingLayer {
//  This is essentially the base url we are hitting when we make the network request
    var baseURL = "https://api.github.com"
    
    func network(route: GithubRoutes, user: GithubUser? = nil, requestRoute: DifferentHttpMethods, completionHandler: @escaping (Data, Int) -> Void) {
        var fullUrlString = URL(string: baseURL.appending(route.path()))
        fullUrlString?.appendingQueryParameters(route.urlParameters())
    }
}

//This is essentially what we call the sanitizing code to be able to implement the parametersr
extension URL {
    func appendingQueryParameters(_ parametersDictionary : Dictionary<String, String>) -> URL {
        let URLString : String = String(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
        return URL(string: URLString)!
    }
    // This is formatting the query parameters with an ascii table reference therefore we can be returned a json file
}

protocol URLQueryParameterStringConvertible {
    var queryParameters: String {get}
}


extension Dictionary : URLQueryParameterStringConvertible {
    /**
     This computed property returns a query parameters string from the given NSDictionary. For
     example, if the input is @{@"day":@"Tuesday", @"month":@"January"}, the output
     string will be @"day=Tuesday&month=January".
     @return The computed parameters string.
     */
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                              String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
    
}

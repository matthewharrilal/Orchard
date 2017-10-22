//
//  NetworkingLayer.swift
//  OrchardClient
//
//  Created by Matthew Harrilal on 10/21/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit


enum Route {
//    This will be the enum to account for the possible routes the user can take to log in
    case users()
    
    func path() -> String {
        switch self {
        case .users:
            return "/users"
        }
    }
    
    func createUser(user: User? = nil) -> Data {
        switch self {
        case .users():
            var jsonBody = Data()
            do {
                jsonBody = try JSONEncoder().encode(user)
            } catch{}
            return jsonBody
        }
    }
}

enum HttpsMethods: String {
    case get = "GET"
    case post = "POST"
}

class LogInNetworkingLayer {
    let session = URLSession.shared
    
    func network(route: Route, user: User? = nil, requestRoute: HttpsMethods, completionHandler: @escaping (Data, Int) -> Void) {
        var baseURL = URL(string: "http://127.0.0.1:5000")
        var request = URLRequest(url: baseURL!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue((user?.credential)!, forHTTPHeaderField: "Authorization")
        if user != nil {
            request.httpMethod = requestRoute.rawValue
            request.httpBody = route.createUser(user: user)
        }
        session.dataTask(with: request) { (data, response, error) in
            let statusCode: Int = (response as! HTTPURLResponse).statusCode
            
            if let data = data {
                print(response)
                completionHandler(data, statusCode)
            }
        }.resume()
       
    }
}

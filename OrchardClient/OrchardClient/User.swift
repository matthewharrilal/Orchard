//
//  User.swift
//  OrchardClient
//
//  Created by Matthew Harrilal on 10/21/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

struct User: Codable {
    var email: String?
    var password: String?
    var credential: String?
    init(email: String?, password: String?) {
        self.email = email
        self.password = password
        self.credential = BasicAuth.generateBasicAuthHeader(username: self.email!, password: self.password!)
    }
}

extension User {
    enum keys: String, CodingKey {
        case email
        case password
    }
    
    init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: keys.self)
    var email = try container.decodeIfPresent(String.self, forKey: .email) ?? "The email address could not be found"
    var password = try container.decodeIfPresent(String.self, forKey: .password) ?? "The password could not be found"
    self.init(email: email, password: password)
    }
}

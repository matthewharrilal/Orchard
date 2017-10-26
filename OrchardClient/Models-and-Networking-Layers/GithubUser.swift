//
//  GithubUser.swift
//  OrchardClient
//
//  Created by Matthew Harrilal on 10/23/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

struct GithubUser: Codable {
     var login: String?
     var email: String?
    init(login: String?, email: String?) {
        self.login = login
        self.email = email
    }
}

extension GithubUser {
    enum Keys: String, CodingKey {
        case login
        case email
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        var login = try container.decodeIfPresent(String.self, forKey: .login) ?? "The login for the users github is nil"
        var email = try container.decodeIfPresent(String.self, forKey: .email) ?? "The email for the user is nil"
        self.init(login: login, email: email)
    }
}

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
    var avatarUrl: String?
    init(login: String?, email: String?, avatarUrl: String?) {
        self.login = login
        self.email = email
        self.avatarUrl = avatarUrl
    }
}

extension GithubUser {
    enum Keys: String, CodingKey {
        case login
        case email
        case avatarUrl = "avatar_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let login = try container.decodeIfPresent(String.self, forKey: .login) ?? "The login for the users github is nil"
        let email = try container.decodeIfPresent(String.self, forKey: .email) ?? "The email for the user is nil"
        let avatarUrl = try container.decodeIfPresent(String.self, forKey: .avatarUrl) ?? "The profile picture for this user is no longer"
        self.init(login: login, email: email, avatarUrl: avatarUrl)
    }
}

struct GithubUserArray: Decodable {
    let items: [GithubUser]
}

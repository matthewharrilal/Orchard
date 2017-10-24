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
    let currentUserURL: String?
    init(currentUserURL: String?) {
        self.currentUserURL = currentUserURL
    }
}

extension GithubUser {
    enum Keys: String, CodingKey {
        case currentUserURL = "current_user_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let currentUserURL = try container.decodeIfPresent(String.self, forKey: .currentUserURL) ?? "The url for the users github is nil"
        self.init(currentUserURL: currentUserURL)
    }
}

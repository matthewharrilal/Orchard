//
//  User.swift
//  OrchardClient
//
//  Created by Matthew Harrilal on 10/21/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class User: NSObject, NSCoding, Codable {
    
    var email: String?
    var password: String?
    var credential: String?
    init(email: String?, password: String?) {
        self.email = email
        self.password = password
        self.credential = BasicAuth.generateBasicAuthHeader(username: self.email!, password: self.password!)
    }
    
    
    enum Keys: String, CodingKey {
        case email
        case password
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        var email = try container.decodeIfPresent(String.self, forKey: .email) ?? "The email address could not be found"
        var password = try container.decodeIfPresent(String.self, forKey: .password) ?? "The password could not be found"
        self.init(email: email, password: password)
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let email = aDecoder.decodeObject(forKey: "email") as? String,
            let password = aDecoder.decodeObject(forKey: "password") as? String,
            let credential = aDecoder.decodeObject(forKey: "credential") as? String
            else{return nil}
        self.email = email
        self.password = password
        self.credential = credential
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(email, forKey: "email")
        aCoder.encode(password, forKey: "password")
        aCoder.encode(credential, forKey: "credential")
    }
    
}



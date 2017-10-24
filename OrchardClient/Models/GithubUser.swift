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
}

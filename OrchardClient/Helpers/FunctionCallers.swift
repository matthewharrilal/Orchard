//
//  FunctionCallers.swift
//  OrchardClient
//
//  Created by Matthew Harrilal on 11/22/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

let userRepostioryNetworkingLayer = UserRepositoriesNetworkingLayer()
let displayUsersInstance = DisplayGithubUsers()

func decodeRepository(){
    userRepostioryNetworkingLayer.network(route: .users(), requestRoute: .get) { (data) in
        guard let repos = try? JSONDecoder().decode([UserGithubRepositories].self, from: data) else {return}
        
        displayUsersInstance.repositoryArray = repos

       print(repos)
    
    }
}





//
//  DisplayUserRepositories.swift
//  OrchardClient
//
//  Created by Matthew Harrilal on 11/22/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class DisplayUserRepositories: UITableViewController {
    var usernameText = ""
    
    var repositories1 = [UserGithubRepositories]()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        FindUsersName.username = usernameText
        print("This is the usernameText \(usernameText)")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("This is the repositories1 \(repositories1)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return repositories1.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let repos = repositories1[indexPath.row]
        cell.textLabel?.text = repos.name
        self.tableView.reloadData()
        return cell
    }
}

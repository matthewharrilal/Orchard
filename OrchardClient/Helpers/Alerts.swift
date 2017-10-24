//
//  Alerts.swift
//  OrchardClient
//
//  Created by Matthew Harrilal on 10/22/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class Alert: UIViewController {
    func logInAlert(controller: UIViewController) {
        let logInFailure = UIAlertController(title: "Log In Failure", message: "Please try logging in again", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Try Again", style: .default, handler: nil)
        logInFailure.addAction(cancelAction)
        controller.present(logInFailure, animated: true, completion: nil)
    }
}

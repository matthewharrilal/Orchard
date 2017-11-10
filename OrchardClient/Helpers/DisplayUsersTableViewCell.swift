//
//  DisplayUsersTableViewCell.swift
//  OrchardClient
//
//  Created by Matthew Harrilal on 11/9/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit


class DisplayUsersTableViewCell: UITableViewCell {

    @IBOutlet weak var displayUsersImageView: UIImageView!
    
    @IBOutlet weak var userLoginLabel: UILabel!
    @IBOutlet weak var userDetailedLabel: UILabel!
    
    override func layoutSubviews() {
        self.contentView.frame = self.bounds
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    
    
}

//
//  DisplayUsersCollectionViewCell.swift
//  OrchardClient
//
//  Created by Matthew Harrilal on 11/9/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class DisplayGithubUserCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var githubUserImageVIew: UIImageView!
       
    
    @IBOutlet weak var userLoginLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 3.0
        layer.shadowRadius = 2
      
    }
}

//
//  CommitsOnRepository.swift
//  OrchardClient
//
//  Created by Matthew Harrilal on 12/2/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit


struct Commits {
    let name: String?
    let message: String?
    let date: String?
    init(name: String?, message: String?, date: String?) {
        self.message = message
        self.date = date
        self.name = name
    }
}


extension Commits: Decodable {
    enum FirstLayerKey: String, CodingKey {
        case commit
    }
    
    enum SecondLayerKey: String, CodingKey {
        case author
        case message
    }
    
   
    
    enum AdditionalKeys: String, CodingKey {
        case name
        case date
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: FirstLayerKey.self)
        let authorContainer = try container.nestedContainer(keyedBy: SecondLayerKey.self, forKey: .commit)
        let message = try authorContainer.decodeIfPresent(String.self, forKey: .message)
        let authorContainer1 = try authorContainer.nestedContainer(keyedBy: AdditionalKeys.self, forKey: .author)
        let name = try authorContainer1.decodeIfPresent(String.self, forKey: .name)
        let date = try authorContainer1.decodeIfPresent(String.self, forKey: .date)
        self.init(name: name, message: message, date: date)
    }
}

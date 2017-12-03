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
    let name: String
    let message: String
    let date: String
    init(name: String, message: String, date: String) {
        self.message = message
        self.date = date
    }
}

extension Commits: Decodable {
    enum FirstLayerKey: String, CodingKey {
        case commit
    }
    
    enum SecondLayerKey: String, CodingKey {
        case author
    }
    
    enum SecondLayerKeys: String, CodingKey {
        case name
        case date
        case message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: FirstLayerKey.self)
        let commitContainer = try container.nestedContainer(keyedBy: SecondLayerKey.self, forKey: .commit)
        let authorContainer = try commitContainer.nestedContainer(keyedBy: SecondLayerKeys.self, forKey: .author)
        let name = try authorContainer.decodeIfPresent(String.self, forKey: .name)
        let date = try authorContainer.decodeIfPresent(String.self, forKey: .date)
        let message = try authorContainer.decodeIfPresent(String.self, forKey: .message)
        self.init(name: name, message: message, date: date)
    }
}

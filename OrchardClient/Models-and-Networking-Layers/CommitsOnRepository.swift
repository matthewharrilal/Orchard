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
    var owner: [Int]?
    var all: [Int]?
    init(owner: [Int]?, all: [Int]?) {
        self.owner = owner
        self.all = all
    }
}

extension Commits: Decodable {
    enum FirstLayerKeys: String, CodingKey {
        case owner
        case all
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: FirstLayerKeys.self)
        let owner = try container.decodeIfPresent([Int].self, forKey: .owner)
        let all = try container.decodeIfPresent([Int].self, forKey: .all)
        self.init(owner: owner, all: all)
    }
}


//extension Commits: Decodable {
//    enum FirstLayerKey: String, CodingKey {
//        case commit
//    }
//
//    enum SecondLayerKey: String, CodingKey {
//        case author
//        case message
//    }
//
//
//
//    enum AdditionalKeys: String, CodingKey {
//        case name
//        case date
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: FirstLayerKey.self)
//        let authorContainer = try container.nestedContainer(keyedBy: SecondLayerKey.self, forKey: .commit)
//        let message = try authorContainer.decodeIfPresent(String.self, forKey: .message)
//        let authorContainer1 = try authorContainer.nestedContainer(keyedBy: AdditionalKeys.self, forKey: .author)
//        let name = try authorContainer1.decodeIfPresent(String.self, forKey: .name)
//        let date = try authorContainer1.decodeIfPresent(String.self, forKey: .date)
//        self.init(name: name, message: message, date: date)
//    }
//}


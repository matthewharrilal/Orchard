import UIKit
import Foundation

struct UserGithubRepositories: Codable {
    // Labeling the properties we want from the JSON
    let name: String?
    let id: Int?
    let description: String?
    init(name: String?, id: Int?, description: String?) {
        self.name = name
        self.id = id
        self.description = description
    }
    
}


extension UserGithubRepositories {
    // Making the coding keys or the keys that match the names of the properties we want from the jsone
    enum FirstLayerKeys: String, CodingKey {
        case name
        case id
        case description
    }
    
    init(from decoder: Decoder) throws {
        // Decoding the properties that we get back from the json
        let container = try decoder.container(keyedBy: FirstLayerKeys.self)
        let name = try container.decodeIfPresent(String.self, forKey: .name)
        let id = try container.decodeIfPresent(Int.self, forKey: .id)
        let description = try container.decodeIfPresent(String.self, forKey: .description)
        self.init(name: name, id: id, description: description)
    }
}

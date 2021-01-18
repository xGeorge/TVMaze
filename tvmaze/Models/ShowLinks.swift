//
//  Showlinks.swift
//  tvmaze
//
//  Created by Jorge Armando Torres Perez on 17/01/21.
//

import Foundation

struct ShowLinks: Codable {
    let linksSelf, previousepisode, nextepisode: SelfClass?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case previousepisode, nextepisode
    }
}

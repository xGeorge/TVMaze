//
//  Show.swift
//  tvmaze
//
//  Created by Jorge Armando Torres Perez on 17/01/21.
//

import Foundation

struct Show: Codable {
    let id: Int?
    let url: String?
    let name, type: String?
    let language: String?
    let genres: [String]?
    let status: String?
    let runtime: Int?
    let premiered: String?
    let officialSite: String?
    let schedule: ScheduleClass?
    let rating: Rating?
    let weight: Int?
    let network, webChannel: Network?
    let externals: Externals?
    let image: Image?
    let summary: String?
    let updated: Int?
    let links: ShowLinks?

    enum CodingKeys: String, CodingKey {
        case id, url, name, type, language, genres, status, runtime, premiered, officialSite, schedule, rating, weight, network, webChannel, externals, image, summary, updated
        case links = "_links"
    }
}

import Foundation

// MARK: - Schedule
struct Schedule: Codable {
    //MARK: View
    let id: Int?
    let url: String?
    let name: String?
    let season: Int?
    let number: Int?
    let type: String?
    let airdate, airtime, airstamp: String?
    let runtime: Int?
    let image: Image?
    let summary: String?
    let show: Show?
    let links: ShowLinks?

    //MARK: ViewModel
    var displayName: String {
        return (name ?? "") + " " + (show?.name ?? "")
    }
    var displayChannel: String {
        return show?.network?.name ?? (show?.webChannel?.name ?? "")
    }

    enum CodingKeys: String, CodingKey {
        case id, url, name, season, number, type, airdate, airtime, airstamp, runtime, image, summary, show
        case links = "_links"
    }
}

// MARK: - SelfClass
struct SelfClass: Codable {
    let href: String?
}

// MARK: - Schedules
typealias Schedules = [Schedule]

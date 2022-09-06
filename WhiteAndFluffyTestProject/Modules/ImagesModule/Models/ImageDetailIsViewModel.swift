import Foundation

struct ImageDetailIsViewModel: Hashable, Codable {
    let regularImageUrl: String
    let smallImageUrl: String
    let creationDate: String
    let location: String?
    let downloads: String?
    let userName: String
}

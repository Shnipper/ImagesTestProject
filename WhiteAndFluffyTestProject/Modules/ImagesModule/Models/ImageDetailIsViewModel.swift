import Foundation

struct ImageDetailIsViewModel: Hashable, Codable {
    let id: String
    let regularImageUrl: String
    let smallImageUrl: String
    let creationDate: String
    let location: String?
    let downloads: String?
    let userName: String
}

extension ImageDetailIsViewModel: Comparable {
   
    static func < (lhs: ImageDetailIsViewModel, rhs: ImageDetailIsViewModel) -> Bool {
        lhs.id < rhs.id
    }
}

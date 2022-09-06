import Foundation

// MARK: - Model example (cropped)

//  [{
//    "id": "LBI7cgq3pbM",
//    
//    "created_at": "2016-05-03T11:00:28-04:00",
//    
//    "downloads": 1345,  // THIS PARAMETERS CAN BE MISSING
//
//    "location": {       // THIS PARAMETERS CAN BE MISSING
//      "name": "Montreal, Canada",
//    },
//
//    "urls": {
//      "raw": "https://images.unsplash.com/face-springmorning.jpg",
//      "full": "https://images.unsplash.com/face-springmorning.jpg?q=75&fm=jpg",
//      "regular": "https://images.unsplash.com/face-springmorning.jpg?q=75&fm=jpg&w=1080&fit=max",
//      "small": "https://images.unsplash.com/face-springmorning.jpg?q=75&fm=jpg&w=400&fit=max",
//      "thumb": "https://images.unsplash.com/face-springmorning.jpg?q=75&fm=jpg&w=200&fit=max"
//    },
//
//    "user": {
//      "name": "Gilbert Kane",
//    }
//    
//  }, ... more Images]

// MARK: - Image Model

struct Image: Decodable {
    let id: String
    let createdAt: String
    let downloads: Int?
    let location: Location?
    let urls: Urls
    let user: User
}

struct Urls: Decodable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

struct User: Decodable {
    let name: String
}

struct Location: Decodable {
    let name: String?
}

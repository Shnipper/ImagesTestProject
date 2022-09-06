import UIKit

enum Resources {
    
    enum SystemImages {
        static let date = UIImage(systemName: "calendar")
        static let location = UIImage(systemName: "mappin.and.ellipse")
        static let downloads = UIImage(systemName: "square.and.arrow.down")
        static let userName = UIImage(systemName: "person")
        static let heart = UIImage(systemName: "heart")
        static let heartFill = UIImage(systemName: "heart.fill")
    }
    
    enum UnknownStrings {
        static let date = "unknown date"
        static let location = "unknown location"
        static let downloads = "0"
        static let userName = "unknown name"
    }
    
    enum ForItem {
        
        enum Titles {
            static let imagesModule = "Images"
            static let favoritesModule = "Favorites"
        }
        
        enum Images {
            static let imagesModule = UIImage(systemName: "photo.on.rectangle.angled")
            static let favoritesModule = UIImage(systemName: "heart.circle.fill")
        }
    }
    
    enum Alert {
        
        enum Messages {
            static let imagesIsEmpty = "Can't find images"
        }
        
        enum Titles {
            static let decodingError = "Image not found, try new request"
            static let invalidRequest = "Invalid Request"
            static let noData = "No Data"
        }
    }
}

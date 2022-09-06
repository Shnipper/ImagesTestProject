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
        
    enum ItemTitles {
        static let imagesModule = "Images"
        static let favoritesModule = "Favorites"
    }
        
    enum ItemImages {
        static let imagesModule = UIImage(systemName: "photo.on.rectangle.angled")
        static let favoritesModule = UIImage(systemName: "heart.circle.fill")
    }
    
    enum AlertMessages {
        static let imagesIsEmpty = "Try new request"
    }
        
    enum AlertTitles {
        static let decodingError = "Image not found"
        static let invalidRequest = "Invalid Request"
        static let noData = "No Data"
    }
}

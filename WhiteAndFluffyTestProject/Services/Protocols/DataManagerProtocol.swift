import Foundation

protocol DataManagerProtocol {
    
    static var shared: DataManager { get }
    
    func getFavoritesImages() -> [ImageDetailIsViewModel]
    func addToFavorites(image: ImageDetailIsViewModel)
    func removeFromFavorites(image: ImageDetailIsViewModel)
    func isFavorite(image: ImageDetailIsViewModel) -> Bool
}


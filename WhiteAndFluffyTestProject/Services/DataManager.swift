import Foundation

final class DataManager: DataManagerProtocol {
    
    private let codingKey = "favoritesImages"
    private var favoriteImages: Set<ImageDetailIsViewModel> = []
    
    static let shared = DataManager()
    private init() {
        downloadFromUserDefaults()
    }
    
    func getFavoritesImages() -> [ImageDetailIsViewModel] {
        return Array(favoriteImages)
    }
    
    func addToFavorites(image: ImageDetailIsViewModel) {
        favoriteImages.insert(image)
        saveToUserDefaults()
    }
    
    func removeFromFavorites(image: ImageDetailIsViewModel) {
        favoriteImages.remove(image)
        saveToUserDefaults()
    }
    
    func isFavorite(image: ImageDetailIsViewModel) -> Bool {
         favoriteImages.contains(image)
    }
}

// MARK: - Private methods

private extension DataManager {
    
    private func saveToUserDefaults() {
        guard let encodedFavoriteImages = try? JSONEncoder().encode(favoriteImages) else { return }
        
        UserDefaults.standard.set(encodedFavoriteImages, forKey: codingKey)
    }
    
    private func downloadFromUserDefaults() {
        guard
            let decodedFavoriteImages = UserDefaults.standard.object(forKey: codingKey) as? Data,
            
            let favoriteImages = try? JSONDecoder().decode(
                Set<ImageDetailIsViewModel>.self,
                from: decodedFavoriteImages)
        else {
            return
        }
        
        self.favoriteImages = favoriteImages
    }
}

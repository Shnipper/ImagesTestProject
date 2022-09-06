import UIKit

protocol ModuleBuilderProtocol {
    
    static var shared: ModuleBuilder { get }
    
    func createImagesModule() -> UIViewController
    func createFavoritesModule() -> UIViewController
    func createImageDetailsModule(imageDetailsViewModel: ImageDetailIsViewModel) -> UIViewController
    
    func createTabBarController() -> UITabBarController
    
}

// MARK: - ModuleBuilderProtocol

final class ModuleBuilder: ModuleBuilderProtocol {
    
    static let shared = ModuleBuilder()
    private init() {}
    
    func createImagesModule() -> UIViewController {
        
        let networkManager = NetworkManager.shared
        
        let viewController = ImagesViewController(networkManager: networkManager)
        
        let navigationController = UINavigationController(rootViewController: viewController)

        navigationController.tabBarItem.title = Resources.ItemTitles.imagesModule
        navigationController.tabBarItem.image = Resources.ItemImages.imagesModule

        return navigationController
    }
    
    func createFavoritesModule() -> UIViewController {
        
        let dataManager = DataManager.shared
        
        let viewController = FavoriteListViewController(dataManager: dataManager)
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        navigationController.tabBarItem.title = Resources.ItemTitles.favoritesModule
        navigationController.tabBarItem.image = Resources.ItemImages.favoritesModule
        
        return navigationController
    }
    
    func createImageDetailsModule(imageDetailsViewModel: ImageDetailIsViewModel) -> UIViewController {
        
        let dataManager = DataManager.shared
        
        let viewController = ImageDetailsViewController(
            dataManager: dataManager,
            imageDetailsViewModel: imageDetailsViewModel)
        
        return viewController
        
    }
    
    func createTabBarController() -> UITabBarController {
        
        let tabBarController = UITabBarController()
        
        tabBarController.tabBar.unselectedItemTintColor = .systemGray
        tabBarController.tabBar.tintColor = .systemBlue
        tabBarController.tabBar.backgroundColor = .systemBackground
        
        return tabBarController
    }
    
}

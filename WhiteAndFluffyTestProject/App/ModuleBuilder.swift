import UIKit

protocol ModuleBuilderProtocol {
    
    func createImagesModule() -> UIViewController
    func createFavoritesModule() -> UIViewController
    func createImageDetailsModule() -> UIViewController
    
    func createTabBarController() -> UITabBarController
    
}

// MARK: - ModuleBuilderProtocol

final class ModuleBuilder: ModuleBuilderProtocol {
    
    func createImagesModule() -> UIViewController {
        
        let networkManager = NetworkManager.shared
        
        let presenter = ImagesPresenter(networkManager: networkManager)
        
        let viewController = ImagesViewController(presenter: presenter)
        
        let navigationController = UINavigationController(rootViewController: viewController)

        navigationController.tabBarItem.image = Resources.ForItem.Images.imagesModule
        navigationController.tabBarItem.title = Resources.ForItem.Titles.imagesModule

        return navigationController
    }
    
    func createFavoritesModule() -> UIViewController {
        let viewController = FavoriteListViewController()
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        navigationController.tabBarItem.title = Resources.ForItem.Titles.favoritesModule
        navigationController.tabBarItem.image = Resources.ForItem.Images.favoritesModule
        
        return navigationController
    }
    
    func createImageDetailsModule() -> UIViewController {
        UIViewController()
    }
    
    func createTabBarController() -> UITabBarController {
        
        let tabBarController = UITabBarController()
        
        tabBarController.tabBar.unselectedItemTintColor = .systemGray
        tabBarController.tabBar.tintColor = .systemBlue
        tabBarController.tabBar.backgroundColor = .systemBackground
        
        return tabBarController
    }
    
}

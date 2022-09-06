import UIKit

protocol CoordinatorProtocol {
    
    init(moduleBuilder: ModuleBuilderProtocol)
    
    func start(_ window: UIWindow)
}

protocol BaseOutputProtocol {
    func didMoveToImageDetails(imageInfoViewModel: ImageDetailIsViewModel)
}

// MARK: - CoordinatorProtocol

final class Coordinator: CoordinatorProtocol {
    
    private let moduleBuilder: ModuleBuilderProtocol
    private var navigationController: UINavigationController?
    
    init(moduleBuilder: ModuleBuilderProtocol) {
        self.moduleBuilder = moduleBuilder
    }
    
    func start(_ window: UIWindow) {
        
        let imagesViewController = moduleBuilder.createImagesModule()
        let favoritesViewController = moduleBuilder.createFavoritesModule()
        
        let tabBarController = moduleBuilder.createTabBarController()
        
        tabBarController.setViewControllers(
            [imagesViewController, favoritesViewController],
            animated: false
        )
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}

extension Coordinator: BaseOutputProtocol {
    func didMoveToImageDetails(imageInfoViewModel: ImageDetailIsViewModel) {
        
    }
}

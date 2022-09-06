import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let moduleBuilder = ModuleBuilder.shared
        
        let imagesViewController = moduleBuilder.createImagesModule()
        let favoritesViewController = moduleBuilder.createFavoritesModule()
        
        let tabBarController = moduleBuilder.createTabBarController()
        
        tabBarController.setViewControllers(
            [imagesViewController, favoritesViewController],
            animated: false
        )
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}

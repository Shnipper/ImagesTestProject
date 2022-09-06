import Foundation

protocol ImagesViewControllerProtocol: AnyObject {
    
    init(presenter: ImagesPresenterProtocol)
}

protocol ImagesPresenterProtocol: AnyObject {
    
    var view: ImagesViewControllerProtocol? { get set }
    
    init(networkManager: NetworkManagerProtocol)
    
}

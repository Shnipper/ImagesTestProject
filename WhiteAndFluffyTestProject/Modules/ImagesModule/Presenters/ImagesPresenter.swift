import Foundation

final class ImagesPresenter: ImagesPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: ImagesViewControllerProtocol?
    
    private let networkManager: NetworkManagerProtocol
    
    private var images: [Image] = []
    
    // MARK: - Init
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

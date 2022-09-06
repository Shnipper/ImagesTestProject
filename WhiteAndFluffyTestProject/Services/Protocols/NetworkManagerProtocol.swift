import Foundation

protocol NetworkManagerProtocol {
    
    static var shared: NetworkManager { get }
    
    func fetchImages(query: String?, completion: @escaping (Result<[Image], NetworkError>) -> Void)
}

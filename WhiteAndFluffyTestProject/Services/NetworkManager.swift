import Foundation

enum NetworkError: Error {
    case invalidRequest
    case noData
    case decodingError
}

private enum Components {
    static let scheme = "https"
    static let host = "api.unsplash.com"
    static let path = "/photos/random"
    static let accessKey = "CQVt6HFnnjmUBE8590YduMWe6BfrsysmcKPqf3jnGVc"
    static let count = "20"
}

// MARK: - NetworkManagerProtocol

final class NetworkManager: NetworkManagerProtocol {
    
    // MARK: - Properties
    
    static let shared = NetworkManager()
    private init() {}
    
    // MARK: Methods
    
    func fetchImages(
        query: String?,
        completion: @escaping (Result<[Image], NetworkError>) -> Void
    ) {
        
        guard let request = makeRequest(query: query) else { return }
        
        URLSession.shared.dataTask(with: request) { data, _, _ in
            
            guard let data = data else {
                return completion(.failure(.noData))
            }
            
            do {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let images = try decoder.decode([Image].self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(images))
                }
                
            } catch {
                
                completion(.failure(.decodingError))
            }
        }
        .resume()
    }
}

// MARK: - Private methods

private extension NetworkManager {

    func makeRequest(query: String?) -> URLRequest? {
        guard let url = makeUrl(with: makeParameters(with: query)) else { return nil }
        
        var request = URLRequest(url: url)
        
        request.allHTTPHeaderFields = makeHeaders()
        request.httpMethod = "GET"
        
        return request
    }
    
    func makeUrl(with parameters: [String: String]) -> URL? {
        var components = URLComponents()
        
        components.scheme = Components.scheme
        components.host = Components.host
        components.path = Components.path
        
        components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        
        return components.url
    }
    
    func makeParameters(with query: String?) -> [String: String] {
        var parameters: [String: String] = [:]
        
        parameters["count"] = Components.count
        
        if let query = query {
            parameters["query"] = query
        }
        
        return parameters
    }
    
    func makeHeaders() -> [String: String] {
        var headers: [String: String] = [:]
        
        headers["Authorization"] = "Client-ID \(Components.accessKey)"
        
        return headers
    }
}

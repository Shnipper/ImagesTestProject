import UIKit

protocol AlertWorkerProtocol {
    static func makeTitle(by error: NetworkError) -> String
    static func makeAlert(with title: String, message: String) -> UIAlertController
    
}

// MARK: - AlertHelperProtocol

final class AlertWorker: AlertWorkerProtocol {
    
    static func makeTitle(by error: NetworkError) -> String {
        
        let title: String
        
        switch error {
        case .decodingError:
            title = Resources.Alert.Titles.decodingError
        case .invalidRequest:
            title = Resources.Alert.Titles.invalidRequest
        case .noData:
            title = Resources.Alert.Titles.noData
        }
        
        return title
    }
    
    static func makeAlert(with title: String, message: String) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(okAction)
        
        return alert
    }
}

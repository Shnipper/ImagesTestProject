import Foundation

protocol ImageDetailsViewControllerProtocol: AnyObject {
    init(
        dataManager: DataManagerProtocol,
        imageDetailsViewModel: ImageDetailIsViewModel
    )
}

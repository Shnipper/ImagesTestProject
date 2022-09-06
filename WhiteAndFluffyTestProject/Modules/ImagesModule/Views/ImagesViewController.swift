import UIKit

final class ImagesViewController: UIViewController {
    
    // MARK: - Views
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(
            ImageCollectionViewCell.self,
            forCellWithReuseIdentifier: ImageCollectionViewCell.reuseId)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    // MARK: - Private properties
    
    private let networkManager: NetworkManagerProtocol
    
    private var images: [Image]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let sectionInsets = UIEdgeInsets(
        top: 20.0,
        left: 20.0,
        bottom: 20.0,
        right: 20.0)
    
    private let itemsPerRow: CGFloat = 2

    // MARK: - Init
    
    required init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        configure()
        setupSearchBar()
        fetchImages(query: nil)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        layoutViews()
    }
}

// MARK: - ImagesViewControllerProtocol

extension ImagesViewController: ImagesViewControllerProtocol {}

// MARK: - UICollectionViewDataSource
    
extension ImagesViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        
        images?.count ?? 10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ImageCollectionViewCell.reuseId,
            for: indexPath
        ) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        
        if let stringUrl = images?[indexPath.row].urls.small,
           let url = URL(string: stringUrl) {
            cell.setImage(with: url)
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ImagesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        
        sectionInsets
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        
        sectionInsets.left
    }
}

// MARK: - UICollectionViewDelegate

extension ImagesViewController: UICollectionViewDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        
        guard let image = images?[indexPath.row] else { return }
        
        let viewModel = makeImageDetailInfoViewModel(by: image)
        
        let imageDetailsViewController = ImageDetailsViewController(
            dataManager: DataManager.shared,
            imageDetailsViewModel: viewModel)
        
        navigationController?.pushViewController(imageDetailsViewController, animated: true)
    }
}

// MARK: - UISearchBarDelegate

extension ImagesViewController: UISearchBarDelegate {
    
    private func setupSearchBar() {
        
        let searchController = UISearchController(searchResultsController: nil)
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.delegate = self
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text?.trimmingCharacters(in: .whitespaces) else { return }

        fetchImages(query: text)
    }
}

// MARK: - Private Methods

private extension ImagesViewController {
    
    func addViews() {
        view.addSubview(collectionView)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func configure() {
        
        view.backgroundColor = .systemBackground
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        navigationItem.title = Resources.ItemTitles.imagesModule
    }
    
    func makeImageDetailInfoViewModel(by image: Image) -> ImageDetailIsViewModel {
        
        ImageDetailIsViewModel(
            regularImageUrl: image.urls.regular,
            smallImageUrl: image.urls.small,
            creationDate: image.createdAt,
            location: image.location?.name,
            downloads: String(image.downloads ?? 0),
            userName: image.user.name)
        
    }
    
    func fetchImages(query: String?) {
        
        networkManager.fetchImages(query: query) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let images):
                self.images = images
                
            case .failure(let error):
                
                DispatchQueue.main.async {
                    self.showAlert(
                        with: AlertWorker.makeTitle(by: error),
                        and: Resources.AlertMessages.imagesIsEmpty
                    )
                }
            }
        }
    }
    
    func showAlert(with title: String, and message: String) {
        let alert = AlertWorker.makeAlert(with: title, message: message)
        present(alert, animated: true)
    }
}

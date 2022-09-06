import UIKit

final class ImageDetailsViewController: UIViewController {
  
    // MARK: - Views
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var creationDateLabel: BaseInfoView = {
        let view = BaseInfoView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.set(image: Resources.SystemImages.date)
        view.set(labelText: Resources.UnknownStrings.date)
        
        return view
    }()
    
    private lazy var locationLabel: BaseInfoView = {
        let view = BaseInfoView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.set(image: Resources.SystemImages.location)
        view.set(labelText: Resources.UnknownStrings.location)
        
        return view
    }()
    
    private lazy var downloadsLabel: BaseInfoView = {
        let view = BaseInfoView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.set(image: Resources.SystemImages.downloads)
        view.set(labelText: Resources.UnknownStrings.downloads)
        
        return view
    }()
    
    private lazy var userNameLabel: BaseInfoView = {
        let view = BaseInfoView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.set(image: Resources.SystemImages.userName)
        view.set(labelText: Resources.UnknownStrings.userName)
        
        return view
    }()
    
    private lazy var favoritesButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBackground
        button.clipsToBounds = true
        button.tintColor = .systemRed
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderColor = UIColor.systemRed.cgColor.copy(alpha: 0.5)
        button.layer.borderWidth = 1
        
        return button
    }()
    
    // MARK: - Private properties
    
    private let dataManager: DataManagerProtocol
    
    private let imageDetailInfo: ImageDetailIsViewModel
    
    private var isFavorite: Bool {
        dataManager.isFavorite(image: imageDetailInfo)
    }
    
    // MARK: - Init
    
    init(
        dataManager: DataManagerProtocol,
        imageDetailsViewModel: ImageDetailIsViewModel
    ) {
        self.dataManager = dataManager
        self.imageDetailInfo = imageDetailsViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overriden methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        addViews()
        configure()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        layoutViews()
        
        favoritesButton.layer.cornerRadius = favoritesButton.frame.width / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureFavoriteButtonImage()
    }
}

// MARK: - ImageDetailsViewControllerProtocol

extension ImageDetailsViewController: ImageDetailsViewControllerProtocol {}

// MARK: - Private methods

private extension ImageDetailsViewController {
    
    func addViews() {
        view.addSubview(imageView)
        view.addSubview(creationDateLabel)
        view.addSubview(locationLabel)
        view.addSubview(downloadsLabel)
        view.addSubview(userNameLabel)
        view.addSubview(favoritesButton)
        
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: view.bounds.width),
            
            creationDateLabel.topAnchor.constraint(
                equalTo: imageView.bottomAnchor, constant: 20),
            
            creationDateLabel.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            
            creationDateLabel.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            creationDateLabel.heightAnchor.constraint(
                equalToConstant: 20),
            
            locationLabel.topAnchor.constraint(equalTo: creationDateLabel.bottomAnchor, constant: 10),
            locationLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            locationLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            downloadsLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            downloadsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            downloadsLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            downloadsLabel.heightAnchor.constraint(equalToConstant: 20),
            
            userNameLabel.topAnchor.constraint(equalTo: downloadsLabel.bottomAnchor, constant: 10),
            userNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            userNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            userNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            favoritesButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 20),
            favoritesButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -20),
            favoritesButton.widthAnchor.constraint(equalToConstant: 50),
            favoritesButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configure() {
        favoritesButton.addTarget(self, action: #selector(favoriteButtonDidTapped), for: .touchUpInside)

        if let url = URL(string: imageDetailInfo.regularImageUrl) {
            imageView.sd_setImage(with: url)
        }
        
        creationDateLabel.set(labelText: formatted(date: imageDetailInfo.creationDate))
        locationLabel.set(labelText: imageDetailInfo.location)
        downloadsLabel.set(labelText: imageDetailInfo.downloads)
        userNameLabel.set(labelText: imageDetailInfo.userName)
    }
    
    func configureFavoriteButtonImage() {
        if isFavorite {
            favoritesButton.setImage(Resources.SystemImages.heartFill, for: .normal)
        } else {
            favoritesButton.setImage(Resources.SystemImages.heart, for: .normal)
        }
    }
    
    @objc
    func favoriteButtonDidTapped() {
        
        if isFavorite {
            dataManager.removeFromFavorites(image: imageDetailInfo)
        } else {
            dataManager.addToFavorites(image: imageDetailInfo)
        }
        
        configureFavoriteButtonImage()
    }
}

// MARK: - Helpers

private extension ImageDetailsViewController {
    
    func formatted(date: String) -> String {
        let formattedDate = String(date.prefix(10))
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        if let tempDate = inputFormatter.date(from: formattedDate) {
            let outputFormatter = DateFormatter()
            
            outputFormatter.locale = Locale(identifier: "en_EN")
            outputFormatter.setLocalizedDateFormatFromTemplate("MMMMddYYYY")
            
            return outputFormatter.string(from: tempDate)
            
        } else {
            return formattedDate
        }
    }
}

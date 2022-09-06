import UIKit

final class FavoriteListViewController: UIViewController, FavoritesListViewControllerProtocol {
    
    // MARK: - Views
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(
            FavoriteTableViewCell.self,
            forCellReuseIdentifier: FavoriteTableViewCell.reuseId)
        
        return tableView
    }()
    
    // MARK: - Private properties
    
    private let dataManager: DataManagerProtocol
    
    private var favoriteImages: [ImageDetailIsViewModel]?
    
    // MARK: - Init
    
    init(dataManager: DataManagerProtocol) {
        self.dataManager = dataManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overriden methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addView()
        configure()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        layoutView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favoriteImages = dataManager.getFavoritesImages()
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension FavoriteListViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        dataManager.getFavoritesImages().count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FavoriteTableViewCell.reuseId,
            for: indexPath
        ) as? FavoriteTableViewCell else { return UITableViewCell() }
        
        guard let imageViewModel = favoriteImages?[indexPath.row],
              let url = URL(string: imageViewModel.smallImageUrl)
        else {
            return UITableViewCell()
        }
        
        cell.setImage(with: url)
        cell.set(userName: imageViewModel.userName)
        
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        
        guard let viewModel = favoriteImages?[indexPath.row] else { return }
        
        tableView.beginUpdates()
        
        dataManager.removeFromFavorites(image: viewModel)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        tableView.endUpdates()
        
//        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension FavoriteListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let viewModel = favoriteImages?[indexPath.row] else { return }
        
        let viewController = ModuleBuilder.shared.createImageDetailsModule(
            imageDetailsViewModel: viewModel)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(
        _ tableView: UITableView,
        editingStyleForRowAt indexPath: IndexPath
    ) -> UITableViewCell.EditingStyle {
        
        .delete
    }
}

// MARK: - Private methods

private extension FavoriteListViewController {
    
    func addView() {
        view.addSubview(tableView)
    }
    
    func layoutView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func configure() {
        navigationItem.title = Resources.ItemTitles.favoritesModule
        
        view.backgroundColor = .systemBackground
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

import UIKit

final class FavoriteListViewController: UIViewController {
    
    // MARK: - Views
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.register(FavoriteTableViewCell.self,
                           forCellReuseIdentifier: FavoriteTableViewCell.reuseId)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var favoriteImages: [ImageDetailIsViewModel]?
    
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
        
        favoriteImages = DataManager.shared.getFavoritesImages()
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension FavoriteListViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        DataManager.shared.getFavoritesImages().count
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
        
        DataManager.shared.removeFromFavorites(image: viewModel)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        tableView.endUpdates()
    }
}

// MARK: - UITableViewDelegate

extension FavoriteListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let viewModel = favoriteImages?[indexPath.row] else { return }
        
        let imageDetailsViewController = ImageDetailsViewController(imageDetailsViewModel: viewModel)
        
        navigationController?.pushViewController(imageDetailsViewController, animated: true)
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

import UIKit
import SDWebImage

final class FavoriteTableViewCell: UITableViewCell {
    
    // MARK: - Views
    
    private lazy var favoriteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Properties
    
    static let reuseId = "FavoriteTableViewCell"
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setImage(with url: URL) {
        favoriteImageView.sd_setImage(with: url)
    }
    
    func set(userName: String) {
        userNameLabel.text = userName
    }
}

// MARK: - Private methods

private extension FavoriteTableViewCell {
    
    func addViews() {
        addSubview(favoriteImageView)
        addSubview(userNameLabel)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            favoriteImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            favoriteImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            favoriteImageView.widthAnchor.constraint(equalToConstant: 80),
            favoriteImageView.heightAnchor.constraint(equalToConstant: 80),
            
            userNameLabel.topAnchor.constraint(equalTo: topAnchor),
            userNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: favoriteImageView.trailingAnchor, constant: 20),
            userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}

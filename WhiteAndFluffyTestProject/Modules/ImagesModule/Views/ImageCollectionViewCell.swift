import UIKit
import SDWebImage

final class ImageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Views
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: Properties
    
    static let reuseId = "ImageCollectionViewCell"
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setImage(with url: URL) {
        imageView.sd_setImage(with: url)
    }
}

// MARK: - Private methods
    
private extension ImageCollectionViewCell {
    
    func addViews() {
        addSubview(imageView)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

import UIKit

final class BaseInfoView: UIView {
    
    // MARK: - Views
    
    private lazy var infoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        addView()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func set(labelText: String?) {
        if let text = labelText {
            infoLabel.text = text
        }
    }
    
    func set(image: UIImage?) {
        if let image = image {
            infoImageView.image = image
        }
    }
}

// MARK: - Private methods

private extension BaseInfoView {
    
    func addView() {
        addSubview(infoImageView)
        addSubview(infoLabel)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            infoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            infoImageView.topAnchor.constraint(equalTo: topAnchor),
            infoImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            infoImageView.widthAnchor.constraint(equalTo: heightAnchor),
            
            infoLabel.centerYAnchor.constraint(equalTo: infoImageView.centerYAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: infoImageView.trailingAnchor, constant: 10),
            infoLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -10),
            infoLabel.heightAnchor.constraint(equalTo: infoImageView.heightAnchor)
        ])
    }
}

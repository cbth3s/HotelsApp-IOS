import UIKit
import Combine

class DetailsViewController: UIViewController {
    var viewModel: DetailsViewModel!
    weak var coordinator: Coordinator?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Hotel Image Section
    private let hotelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray.withAlphaComponent(0.1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let imageLoadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .systemGray
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.isHidden = true
        return indicator
    }()
    
    // MARK: Main Loading Indicator
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .systemGray
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.isHidden = true
        return indicator
    }()
    
    // MARK: Hotel Info Section (теперь под картинкой)
    private let starsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .systemYellow
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Distance Section
    private let distanceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "figure.walk")
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .darkText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Rooms Section
    private let roomsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "door.right.hand.open")
        imageView.tintColor = .systemGreen
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let roomsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .darkText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let roomsListLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        bindViewModel()
        
        Task {
            await viewModel.loadData()
        }
    }
    
    private func setupUI() {
        view.addSubview(hotelImageView)
        view.addSubview(imageLoadingIndicator)
        view.addSubview(activityIndicator)
        view.addSubview(starsLabel)
        view.addSubview(starImageView)
        view.addSubview(nameLabel)
        view.addSubview(addressLabel)
        view.addSubview(distanceImageView)
        view.addSubview(distanceLabel)
        view.addSubview(roomsImageView)
        view.addSubview(roomsLabel)
        view.addSubview(roomsListLabel)
        
        NSLayoutConstraint.activate([
            hotelImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hotelImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hotelImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hotelImageView.heightAnchor.constraint(equalToConstant: 500),
            
            imageLoadingIndicator.centerXAnchor.constraint(equalTo: hotelImageView.centerXAnchor),
            imageLoadingIndicator.centerYAnchor.constraint(equalTo: hotelImageView.centerYAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            starsLabel.topAnchor.constraint(equalTo: hotelImageView.bottomAnchor, constant: 16),
            starsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            starImageView.leadingAnchor.constraint(equalTo: starsLabel.trailingAnchor, constant: 4),
            starImageView.centerYAnchor.constraint(equalTo: starsLabel.centerYAnchor),
            starImageView.widthAnchor.constraint(equalToConstant: 16),
            starImageView.heightAnchor.constraint(equalToConstant: 16),
            
            nameLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 8),
            nameLabel.centerYAnchor.constraint(equalTo: starsLabel.centerYAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            addressLabel.topAnchor.constraint(equalTo: starsLabel.bottomAnchor, constant: 8),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            distanceImageView.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 24),
            distanceImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            distanceImageView.widthAnchor.constraint(equalToConstant: 24),
            distanceImageView.heightAnchor.constraint(equalToConstant: 24),
            
            distanceLabel.leadingAnchor.constraint(equalTo: distanceImageView.trailingAnchor, constant: 8),
            distanceLabel.centerYAnchor.constraint(equalTo: distanceImageView.centerYAnchor),
            
            roomsImageView.topAnchor.constraint(equalTo: distanceImageView.bottomAnchor, constant: 16),
            roomsImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            roomsImageView.widthAnchor.constraint(equalToConstant: 24),
            roomsImageView.heightAnchor.constraint(equalToConstant: 24),
            
            roomsLabel.leadingAnchor.constraint(equalTo: roomsImageView.trailingAnchor, constant: 8),
            roomsLabel.centerYAnchor.constraint(equalTo: roomsImageView.centerYAnchor),
            
            roomsListLabel.topAnchor.constraint(equalTo: roomsImageView.bottomAnchor, constant: 8),
            roomsListLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            roomsListLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func bindViewModel() {
        viewModel.$imageData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] imageData in
                guard let self = self else { return }
                self.updateHotelImage(with: imageData)
            }
            .store(in: &cancellables)
        
        viewModel.$details
            .receive(on: DispatchQueue.main)
            .sink { [weak self] details in
                guard let self = self else { return }
                if let details = details {
                    self.updateUI(with: details)
                }
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self = self else { return }
                
                if isLoading {
                    self.showMainLoading()
                } else {
                    self.hideMainLoading()
                }
            }
            .store(in: &cancellables)
        
        viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                
                if error != nil {
                    self?.presentErrorAlert()
                }
            }
            .store(in: &cancellables)
    }
    
    private func presentErrorAlert() {
        let alert = UIAlertController(
            title: "Error",
            message: "Temporarily unavailable",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
            self?.coordinator?.pop()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func updateHotelImage(with imageData: Data?) {
        imageLoadingIndicator.stopAnimating()
        imageLoadingIndicator.isHidden = true
        
        guard let imageData = imageData, let image = UIImage(data: imageData) else {
            hotelImageView.image = nil
            return
        }
        
        hotelImageView.image = image
        hotelImageView.contentMode = .scaleAspectFill
        
    }
    
    private func showMainLoading() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        imageLoadingIndicator.isHidden = false
        imageLoadingIndicator.startAnimating()
        
        let contentViews = [
            starsLabel, starImageView, nameLabel, addressLabel,
            distanceImageView, distanceLabel, roomsImageView,
            roomsLabel, roomsListLabel
        ]
        
        contentViews.forEach {
            $0.alpha = 0.3
            $0.isUserInteractionEnabled = false
        }
    }
    
    private func hideMainLoading() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        
        let contentViews = [
            starsLabel, starImageView, nameLabel, addressLabel,
            distanceImageView, distanceLabel, roomsImageView,
            roomsLabel, roomsListLabel
        ]
        
        contentViews.forEach {
            $0.alpha = 1.0
            $0.isUserInteractionEnabled = true
        }
    }
    
    private func updateUI(with details: DetailsHotelModel) {
        starsLabel.text = viewModel.toString(details.stars)
        nameLabel.text = details.name
        addressLabel.text = details.address
        distanceLabel.text = "\(viewModel.toString(details.distance))m"
        roomsLabel.text = "Available rooms:"
        roomsListLabel.text = viewModel.formatRoomNumbers(details.suitesAvailability)
    }
}

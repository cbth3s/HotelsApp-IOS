
import SwiftUI

struct DetailsRepresentable: UIViewControllerRepresentable {
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject private var viewModel: DetailsViewModel
    
    let hotelID: Int
    
    init(hotelID: Int) {
        self.hotelID = hotelID
        _viewModel = StateObject(wrappedValue: DetailsViewModelFactory.makeDetailsViewModel(for: hotelID))
    }
    
    func makeUIViewController(context: Context) -> DetailsViewController {
        let viewController = DetailsViewController()
        viewController.viewModel = viewModel
        viewController.coordinator = coordinator
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
}


import SwiftUI

struct DetailsRepresentable: UIViewControllerRepresentable {
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject private var viewModel: DetailsViewModel
    
    init(viewModel: DetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    func makeUIViewController(context: Context) -> DetailsViewController {
        let viewController = DetailsViewController(viewModel: viewModel)
        viewController.coordinator = coordinator
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
}

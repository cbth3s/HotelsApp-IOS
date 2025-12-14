
import SwiftUI
import Combine

@MainActor
final class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    @ViewBuilder
    func makeView(_ route: Screen) -> some View {
        switch route {
        case .listHotels: ListHotelsView().environmentObject(self)
        case .detailsHotel(let hotelID): DetailsRepresentable(hotelID: hotelID).environmentObject(self)
        }
    }
    
    func push(_ route: Screen) {
        path.append(route)
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
}

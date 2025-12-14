
import SwiftUI
import Combine

@MainActor
final class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    private let networkService: NetworkServiceProtocol
    private let decoder: DecoderProtocol
    private let hotelService: HotelServiceProtocol
    init() {
        self.networkService = NetworkService()
        self.decoder = Decoder()
        self.hotelService = HotelService(networkService: networkService, decoder: decoder)
    }
    
    @ViewBuilder
    func makeView(_ route: Screen) -> some View {
        switch route {
        case .listHotels:
            ListHotelsView(vm: HotelsViewModelFactory.makeListHotelViewModel(hotelService: hotelService)).environmentObject(self)
        case .detailsHotel(let hotelID):
            DetailsRepresentable(hotelID: hotelID, hotelService: hotelService).environmentObject(self)
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

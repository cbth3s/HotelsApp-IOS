
import Foundation

struct DetailsViewModelFactory {
    static func makeDetailsViewModel(for hotelID: Int) -> DetailsViewModel {
        let networkService = NetworkService()
        let decoder = Decoder()
        let hotelService = HotelService(
            networkService: networkService,
            decoder: decoder
        )
        return DetailsViewModel(hotelService: hotelService, hotelID: hotelID)
    }
}

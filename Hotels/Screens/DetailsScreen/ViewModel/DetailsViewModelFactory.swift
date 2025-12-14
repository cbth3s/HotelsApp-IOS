
import Foundation

struct DetailsViewModelFactory {
    static func makeDetailsViewModel(hotelService: HotelServiceProtocol, for hotelID: Int) -> DetailsViewModel {
        return DetailsViewModel(hotelService: hotelService, hotelID: hotelID)
    }
}

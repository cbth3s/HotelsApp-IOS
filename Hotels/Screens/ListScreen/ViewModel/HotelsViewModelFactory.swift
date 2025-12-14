
import Foundation

struct HotelsViewModelFactory {
    static func makeListHotelViewModel() -> ListHotelsViewModel {
        let networkService = NetworkService()
        let decoder = Decoder()
        let hotelService = HotelService(
            networkService: networkService,
            decoder: decoder
        )
        return ListHotelsViewModel(hotelService: hotelService)
    }
}

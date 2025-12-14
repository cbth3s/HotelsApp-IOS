
import Foundation

struct HotelsViewModelFactory {
    static func makeListHotelViewModel(hotelService: HotelServiceProtocol) -> ListHotelsViewModel {
        return ListHotelsViewModel(hotelService: hotelService)
    }
}

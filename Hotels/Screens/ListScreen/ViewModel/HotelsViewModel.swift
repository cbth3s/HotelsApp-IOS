
import SwiftUI
import Combine

@MainActor
final class ListHotelsViewModel: ObservableObject {
    
    @Published private(set) var hotels: [HotelModel] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var error: Error?
    
    let hotelService: HotelServiceProtocol
    
    init(hotelService: HotelServiceProtocol) {
        self.hotelService = hotelService
    }
    
    func loadData() async {
        isLoading = true
        error = nil
        do {
            hotels = try await hotelService.loadHotelInfo()
        } catch {
            self.error = error
            print("ERROR LOAD: \(error.localizedDescription)")
        }
        isLoading = false
    }
}

extension ListHotelsViewModel {
    func toString<T>(_ value: T) -> String {
        "\(value)"
    }
    
    func getFreeRoomsCount(_ value: String) -> Int {
        guard !value.isEmpty else { return 0 }
        return value.split(separator: ":").count
    }
    
    enum SortKey {
        case byDistance, byRooms
    }
    enum SortOrder {
        case ascending, descending
    }
    
    func sortHotels(by key: SortKey, order: SortOrder) async {
        switch key {
        case .byDistance:
            if order == .ascending {
                hotels = hotels.sorted { $0.distance < $1.distance }
            } else {
                hotels = hotels.sorted { $0.distance > $1.distance }
            }
        case .byRooms:
            if order == .ascending {
                hotels = hotels.sorted { getFreeRoomsCount($0.suitesAvailability) < getFreeRoomsCount($1.suitesAvailability) }
            } else {
                hotels = hotels.sorted { getFreeRoomsCount($0.suitesAvailability) > getFreeRoomsCount($1.suitesAvailability) }
            }
        }
    }
}


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
    
    func sortedByRooms() async {
        hotels = hotels.sorted(by: { getFreeRoomsCount($0.suitesAvailability) > getFreeRoomsCount($1.suitesAvailability) })
    }
    
    func sortedByDistance() async {
        hotels = hotels.sorted(by: {$0.distance < $1.distance })
    }
    
    func getFreeRoomsCount(_ value: String) -> Int {
        guard !value.isEmpty else { return 0 }
        return value.reduce(0) { $0 + ($1 == ":" ? 1 : 0) } + 1
    }
}

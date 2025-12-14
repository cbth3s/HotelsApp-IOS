
import Foundation

struct HotelModel: Identifiable, Codable, Sendable {
    let id: Int
    let name: String
    let address: String
    let stars: Float
    let distance: Float
    let suitesAvailability: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case address
        case stars
        case distance
        case suitesAvailability = "suites_availability"
    }
}


import Foundation

struct DetailsHotelModel: Identifiable, Codable, Sendable {
    let id: Int
    let name: String
    let address: String
    let stars: Float
    let distance: Float
    let image: String
    let suitesAvailability: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case address
        case stars
        case distance
        case image
        case suitesAvailability = "suites_availability"
    }
}


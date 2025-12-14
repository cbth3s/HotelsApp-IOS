
import Foundation

struct APIEndpoint {
    private static let baseDataURL = "https://raw.githubusercontent.com/cbth3s/HotelsApp-Backend/heads/main"
    
    static func hotelList() -> URL? {
        URL(string: baseDataURL + "/hotels.json")
    }
    
    static func hotelDetails(id: Int) -> URL? {
        URL(string: baseDataURL + "/details/\(id).json")
    }
    
    static func hotelImage(name: String) -> URL? {
        URL(string: baseDataURL + name)
    }
}

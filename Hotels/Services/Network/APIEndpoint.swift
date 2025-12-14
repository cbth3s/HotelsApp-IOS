
import Foundation

struct APIEndpoint {
    private static let baseDataURL = "https://raw.githubusercontent.com/cbth3s/HotelsApp-Backend/heads/main"
    private static let baseDataLocalURL = "http://127.0.0.1:8000"
    
    static func hotelList() -> URL? {
        URL(string: baseDataURL + "/hotels.json")
    }
    
    static func hotelDetails(id: Int) -> URL? {
        URL(string: baseDataURL + "/details/\(id).json")
    }
    
    static func hotelImage(name: String) -> URL? {
        URL(string: baseDataURL + name)
    }
    
    // MARK: API endpoints
    
    static func localHotelList() -> URL? {
        URL(string: baseDataLocalURL + "/hotels")
    }
    
    static func localHotelDetails(id: Int) -> URL? {
        URL(string: baseDataLocalURL + "/hotels/\(id)/details")
    }
    
    static func localLoadImage(path: String) -> URL? {
        URL(string: baseDataLocalURL + path)
    }
}

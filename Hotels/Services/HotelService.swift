
import Foundation

protocol HotelServiceProtocol {
    func loadHotelInfo() async throws -> [HotelModel]
    func loadDetailsHotel(hotelID: Int) async throws -> DetailsHotelModel?
    func loadImage(image: String) async throws -> Data 
}

final class HotelService: HotelServiceProtocol {
    let networkService: NetworkServiceProtocol
    let decoder: DecoderProtocol
    
    init(
        networkService: NetworkServiceProtocol,
        decoder: DecoderProtocol
    ) {
        self.networkService = networkService
        self.decoder = decoder
    }
    
    func loadHotelInfo() async throws -> [HotelModel] {
        guard let url = APIEndpoint.hotelList() else {
            throw URLError(.badURL)
        }
        let data = try await networkService.fetchData(from: url)
        let result = try decoder.decode([HotelModel].self, from: data)
        return result
    }
    
    func loadDetailsHotel(hotelID: Int) async throws -> DetailsHotelModel? {
        guard let url = APIEndpoint.hotelDetails(id: hotelID) else {
            throw URLError(.badURL)
        }
        let data = try await networkService.fetchData(from: url)
        let result = try decoder.decode(DetailsHotelModel.self, from: data)
        return result
    }
    
    func loadImage(image: String) async throws -> Data {
        guard let url = APIEndpoint.hotelImage(name: image) else {
            throw URLError(.badURL)
        }
        let data = try await networkService.fetchData(from: url)
        return data
    }
}

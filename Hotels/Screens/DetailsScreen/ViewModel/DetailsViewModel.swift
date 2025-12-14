
import Combine
import UIKit

@MainActor
final class DetailsViewModel: ObservableObject {
    @Published private(set) var details: DetailsHotelModel?
    @Published private(set) var imageData: Data?
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var isLoadingImage: Bool = false
    @Published private(set) var error: Error?
    
    let hotelService: HotelServiceProtocol
    let hotelID: Int
    
    private var cancellables = Set<AnyCancellable>()
    
    init(hotelService: HotelServiceProtocol, hotelID: Int) {
        self.hotelService = hotelService
        self.hotelID = hotelID
    }
    
    func loadData() async {
        isLoading = true
        error = nil
        do {
            details = try await hotelService.loadDetailsHotel(hotelID: hotelID)
            guard let details = details else {
                throw URLError(.fileDoesNotExist)
            }
            await loadImage(imageID: details.image)
        } catch {
            self.error = error
            print("ERROR LOADED: \(error.localizedDescription)")
        }
        isLoading = false
    }
}

extension DetailsViewModel {
    func toString<T>(_ value: T) -> String {
        "\(value)"
    }
    
    func formatRoomNumbers(_ roomString: String) -> String {
        roomString.replacingOccurrences(of: ":", with: ", ")
    }
}

private extension DetailsViewModel {
    private func loadImage(imageID: String) async {
        isLoadingImage = true
        do {
            let data = try await hotelService.loadImage(image: imageID)
            let croppedImage = cropOnePixelBorder(from: data)
            await MainActor.run {
                self.imageData = croppedImage ?? data
            }
        } catch {
            print("FAILED TO LOAD IMAGE: \(error.localizedDescription)")
        }
        isLoadingImage = false
    }
    
    private func cropOnePixelBorder(from data: Data) -> Data? {
        guard let image = UIImage(data: data),
              let cgImage = image.cgImage else {
            return nil
        }

        let width = cgImage.width
        let height = cgImage.height
        
        guard width > 2 && height > 2 else { return nil }
        let cropRect = CGRect(x: 1, y: 1, width: width - 2, height: height - 2)
        guard let croppedCGImage = cgImage.cropping(to: cropRect) else { return nil }
        let croppedImage = UIImage(cgImage: croppedCGImage,
                                   scale: image.scale,
                                   orientation: image.imageOrientation)
        return croppedImage.jpegData(compressionQuality: 1.0) ?? croppedImage.pngData()
    }
}

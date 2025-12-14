
import SwiftUI

struct CoordinatorView: View {
    @StateObject private var coordinator = Coordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.makeView(.listHotels)
                .environmentObject(coordinator)
                .navigationDestination(for: Screen.self) {
                    coordinator.makeView($0)
                }
        }
    }
}


import SwiftUI

struct ListHotelsView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject private var vm: ListHotelsViewModel
    
    @State private var currentSorting: FilterButtonView.SortingType?
    @State private var showErrorAlert: Bool = false
    @State private var distanceSortOrder: ListHotelsViewModel.SortOrder = .ascending
    @State private var roomsSortOrder: ListHotelsViewModel.SortOrder = .ascending
    
    init(vm: ListHotelsViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        ZStack {
            if vm.isLoading {
                ProgressView()
            }
            
            List(vm.hotels) { hotel in
                CardHotelView(
                    name: hotel.name,
                    stars: vm.toString(hotel.stars),
                    distance: vm.toString(hotel.distance),
                    address: hotel.address,
                    roomsCount: vm.toString(vm.getFreeRoomsCount(hotel.suitesAvailability))
                ) {
                    coordinator.push(.detailsHotel(hotelID: hotel.id))
                }
                .listRowSeparator(.hidden)
                .listRowInsets(
                    EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
                )
            }
            .listStyle(.plain)
        }
        .toolbar {
            toolbarItems
        }
        .task {
            await vm.loadData()
        }
        .onReceive(vm.$error) { error in
            if error != nil {
                showErrorAlert = true
            }
        }
        .alert("Error", isPresented: $showErrorAlert) {
            Button("Повторить") {
                Task {
                    await vm.loadData()
                }
            }
        } message: {
            Text("Data loading error")
        }
    }
}

private extension ListHotelsView {
    @ToolbarContentBuilder
    private var toolbarItems: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            FilterButtonView(
                currentSorting: $currentSorting,
                distanceSortOrder: distanceSortOrder,
                roomsSortOrder: roomsSortOrder
            ) {
                Task {
                    let newOrder: ListHotelsViewModel.SortOrder = (distanceSortOrder == .ascending) ? .descending : .ascending
                    await vm.sortHotels(by: .byDistance, order: newOrder)
                    await MainActor.run {
                        distanceSortOrder = newOrder
                        currentSorting = .distance
                    }
                }
            } sortByRooms: {
                Task {
                    let newOrder: ListHotelsViewModel.SortOrder = (roomsSortOrder == .ascending) ? .descending : .ascending
                    await vm.sortHotels(by: .byRooms, order: newOrder)
                    await MainActor.run {
                        roomsSortOrder = newOrder
                        currentSorting = .rooms
                    }
                }
            }
        }
    }
}

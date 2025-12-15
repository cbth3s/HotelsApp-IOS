
import SwiftUI

struct FilterButtonView: View {
    @Binding var currentSorting: SortingType?
    
    let distanceSortOrder: ListHotelsViewModel.SortOrder
    let roomsSortOrder: ListHotelsViewModel.SortOrder
    
    let sortByDistance: () -> Void
    let sortByRooms: () -> Void
    
    enum SortingType {
        case distance
        case rooms
    }
    
    var body: some View {
        Menu {
            Button {
                sortByDistance()
            } label: {
                HStack {
                    Text("By Distance")
                    Spacer()
                    if currentSorting == .distance {
                        Image(systemName: distanceSortOrder == .ascending ? "arrow.up" : "arrow.down")
                            .foregroundStyle(.blue)
                    }
                }
            }
            
            Button {
                sortByRooms()
            } label: {
                HStack {
                    Text("By Rooms")
                    Spacer()
                    if currentSorting == .rooms {
                        Image(systemName: roomsSortOrder == .ascending ? "arrow.up" : "arrow.down")
                            .foregroundStyle(.blue)
                    }
                }
            }
        } label: {
            Image(systemName: iconName)
                .foregroundStyle(.accent)
                .font(.title2)
                .padding(8)
        }
    }
}

private extension FilterButtonView {
    
    private var iconName: String {
        switch currentSorting {
        case .distance:
            return "figure.walk"
        case .rooms:
            return "door.right.hand.open"
        case .none:
            return "arrow.up.arrow.down"
        }
    }
}


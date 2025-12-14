
import SwiftUI

struct FilterButtonView: View {
    @Binding var currentSorting: SortingType?
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
                        Image(systemName: "checkmark")
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
                        Image(systemName: "checkmark")
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
            return "slider.vertical.3"
        }
    }
}


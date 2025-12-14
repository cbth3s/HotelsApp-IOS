
import SwiftUI

struct CardHotelView: View {
    let name: String
    let stars: String
    let distance: String
    let address: String
    let roomsCount: String
    let action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            title
            HStack{
                lenght
                rooms
            }
        }
        .padding(.leading, 5)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height:90)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.accent, lineWidth: 2)
                
        }
        .onTapGesture {
            action()
        }
    }
}

private extension CardHotelView {
    private var title: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 2) {
                Text(stars)
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
                Text(name).bold()
            }
            Text(address)
                .font(.caption)
        }
    }
    
    private var rooms: some View {
        HStack(spacing: 2) {
            Image(systemName: "door.right.hand.open")
                .foregroundStyle(.green)
            Text("\(roomsCount)")
        }
    }
    
    private var lenght: some View {
        HStack(spacing: 2) {
            Image(systemName: "figure.walk")
                .foregroundStyle(.blue)
            Text("\(distance)m")
        }
    }
}



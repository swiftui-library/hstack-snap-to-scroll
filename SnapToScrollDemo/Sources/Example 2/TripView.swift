import SwiftUI

// MARK: - TripView

struct TripView: View {

    let viewModel: TripModel

    var body: some View {

        VStack(alignment: .leading) {

            HStack(spacing: 12) {

                Image(viewModel.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 75, height: 75)
                    .cornerRadius(18)
                    .clipped()

                VStack(alignment: .leading, spacing: 6) {

                    Text(viewModel.destination)
                        .font(.headline)
                    Text("$\(Int(viewModel.startingPrice)) starting")
                        .font(.subheadline)
                }
                
                Spacer()
            }
        }
    }
}

// MARK: - TripView_Previews

struct TripView_Previews: PreviewProvider {

    static var previews: some View {

        TripView(viewModel: TripModel.newYork)
    }
}

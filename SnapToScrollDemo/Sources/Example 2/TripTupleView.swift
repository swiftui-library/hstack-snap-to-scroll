import SwiftUI

// MARK: - TripTupleView

struct TripTupleView: View {

    let viewModel: TripTupleModel

    var body: some View {

        VStack(alignment: .leading) {

            TripView(viewModel: viewModel.trip1)


            TripView(viewModel: viewModel.trip2)
        }
    }
}

// MARK: - TripTupleView_Previews

struct TripTupleView_Previews: PreviewProvider {
    static var previews: some View {

        TripTupleView(viewModel: TripTupleModel.exampleModels.first!)
    }
}

import SwiftUI
import SnapToScroll

// MARK: - Example2ContentView

struct Example2ContentView: View {
    var body: some View {

        VStack {

            Text("Explore Nearby")
                .font(.system(size: 22, weight: .semibold, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.top, .leading], 16)

            HStackSnap(alignment: .leading(16)) {

                ForEach(TripTupleModel.exampleModels) { viewModel in

                    TripTupleView(viewModel: viewModel)
                        .frame(maxWidth: 250)
                        .snapAlignmentHelper(id: viewModel.id)
                }
            } onSwipe: { index in

                print(index)
            }
            .frame(height: 130)
            .padding(.top, 4)
        }
    }
}

// MARK: - Example2ContentView_Previews

struct Example2ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Example2ContentView()
    }
}

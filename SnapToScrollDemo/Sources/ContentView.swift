import SnapToScroll
import SwiftUI

// MARK: - ContentView

struct ContentView: View {

    @State var items = [("one", 1), ("two", 2), ("three", 3), ("four", 4), ("five", 5), ("six", 6)]

    var body: some View {
        VStack {

            ScrollView {

                VerticalSpace
                
                VStack {

                    LargeHeader(text: "Example 1")

                    Example1HeaderView()

                    // Don't forget to attach GeometryReaderOverlay!
                    HStackSnap(leadingOffset: 16) {

                        ForEach(TagModel.exampleModels) { viewModel in

                            TagView(viewModel: viewModel)
                                .overlay(GeometryReaderOverlay(id: viewModel.id))
                        }
                    }.padding(.top, 4)
                }

                VerticalSpace

                VStack {

                    LargeHeader(text: "Example 2")

                    Text("Explore Nearby")
                        .font(.system(size: 22, weight: .semibold, design: .rounded))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.top, .leading], 16)

                    HStackSnap(leadingOffset: 16) {

                        ForEach(TripTupleModel.exampleModels) { viewModel in

                            TripTupleView(viewModel: viewModel)
                                .frame(maxWidth: 250)
                                .overlay(GeometryReaderOverlay(id: viewModel.id))
                        }
                    }
                    .frame(height: 200)
                    .padding(.top, 4)
                }
            }
        }
        .preferredColorScheme(.light)
    }

    var VerticalSpace: some View {

        VStack {}
            .frame(height: 64)
    }

    func LargeHeader(text: String) -> some View {

        return
            Text(text)
                .font(.largeTitle)
                .fontWeight(.bold)
                .opacity(0.5)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
    }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

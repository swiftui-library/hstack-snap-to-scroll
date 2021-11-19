import SnapToScroll
import SwiftUI

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
            } eventHandler: { event in
                
                handleSnapToScrollEvent(event: event)
            }
            .frame(height: 130)
            .padding(.top, 4)
        }
    }

    func handleSnapToScrollEvent(event: SnapToScrollEvent) {
        
        switch event {
            
            case let .didLayout(layoutInfo: layoutInfo):

                print("\(layoutInfo.keys.count) items layed out")
            
            case let .swipe(index: index):

                print("swiped to index: \(index)")
        }
    }
}

// MARK: - Example2ContentView_Previews

struct Example2ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Example2ContentView()
    }
}

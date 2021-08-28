import SnapToScroll
import SwiftUI

// MARK: - ContentView

struct ContentView: View {
    
    @State var items = [("one", UUID()), ("two", UUID()), ("three", UUID()), ("four", UUID()), ("five", UUID()), ("six", UUID())]
    
    var body: some View {
        VStack {
            
            HStackSnap {
                
                ForEach(items, id: \.1) { item in
                    
                    Text(item.0)
                        .font(.largeTitle)
                        .padding()
                        .overlay(GeometryReaderOverlay(id: item.1))
                }
            }
        }
        
        /// SnapHStack {
        ///      customForEach { item in
        ///
        ///      }
        ///      }
    }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

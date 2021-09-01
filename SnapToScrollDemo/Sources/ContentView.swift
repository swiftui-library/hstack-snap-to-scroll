import SnapToScroll
import SwiftUI

// MARK: - ContentView

struct ContentView: View {

    var body: some View {
        VStack {

            ScrollView {

                VerticalSpace
                
                LargeHeader(text: "Example 1")
                
                Example1ContentView()

                VerticalSpace

               LargeHeader(text: "Example 2")
                
                Example2ContentView()
                
                VerticalSpace

                LargeHeader(text: "Example 3")
                
                Example3ContentView()
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

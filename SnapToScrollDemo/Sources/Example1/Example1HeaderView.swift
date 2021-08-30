import SwiftUI

// MARK: - Example1HeaderView

struct Example1HeaderView: View {
    var body: some View {

        HStack {

            Text("Downtown")
                .foregroundColor(.gray)

            Spacer()

            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 0, y: 3)
        .padding([.leading, .trailing], 16)
    }
}

// MARK: - Example1HeaderView_Previews

struct Example1HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Example1HeaderView()
    }
}

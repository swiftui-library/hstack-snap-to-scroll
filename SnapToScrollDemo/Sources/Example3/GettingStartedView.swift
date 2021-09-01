import SwiftUI

// MARK: - GettingStartedView

struct GettingStartedView: View {

    @Binding var selectedIndex: Int

    let viewModel: GettingStartedModel

    var body: some View {

        VStack(alignment: .leading) {

            Image(systemName: viewModel.systemImage)
                .foregroundColor(isSelected ? Color("LightPink") : .gray)
                .font(.system(size: 32))
                .padding(.bottom, 2)

            Text(viewModel.title)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 1)
                .opacity(0.8)

            Text(viewModel.body)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .opacity(0.8)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .opacity(isSelected ? 1 : 0.8)
    }

    var isSelected: Bool {

        return selectedIndex == viewModel.id
    }
}

// MARK: - GettingStartedView_Previews

struct GettingStartedView_Previews: PreviewProvider {
    static var previews: some View {

        GettingStartedView(
            selectedIndex: .constant(0),
            viewModel: GettingStartedModel.exampleModels.first!)
    }
}

import SwiftUI

// MARK: - TagView

struct TagView: View {
    
    let viewModel: TagModel
    
    var body: some View {
        
        HStack {
            
            Image(systemName: viewModel.systemImage)
                .foregroundColor(.blue)
            
            Text(viewModel.label)
                .fontWeight(.semibold)
                .foregroundColor(.blue)
            
            Text("\(Int(viewModel.timeEstimate)) min")
                .foregroundColor(.blue)
        }
        .padding(6)
        .background(Color.blue.opacity(0.1))
        .cornerRadius(6)
    }
}

// MARK: - TagView_Previews

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        
        TagView(viewModel: .init(id: 1, systemImage: "tram", label: "Tram", timeEstimate: 23))
    }
}

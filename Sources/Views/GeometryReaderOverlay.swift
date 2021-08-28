import Foundation
import SwiftUI

public struct GeometryReaderOverlay: View {

    let id: UUID
    
    public init(id: UUID) {
        
        self.id = id
    }
    
    public var body: some View {
        
        GeometryReader { geometry in
            
            Rectangle().fill(Color.blue.opacity(0.5))
                .preference(
                    key: ContentPreferenceKey.self,
                    value: [ContentPreferenceData(
                        id: id,
                        rect: geometry.frame(in: .named(ContentPreferenceKey.coordinateSpace)))])
        }
    }
}

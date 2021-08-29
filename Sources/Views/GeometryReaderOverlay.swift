import Foundation
import SwiftUI

public struct GeometryReaderOverlay: View {

    // MARK: Lifecycle

    public init(id: UUID, coordinateSpace: String = "SnapToScroll") {

        self.id = id
        self.coordinateSpace = coordinateSpace
    }

    // MARK: Public

    public var body: some View {

        GeometryReader { geometry in

            Rectangle().fill(Color.blue.opacity(0.5))
                .preference(
                    key: ContentPreferenceKey.self,
                    value: [ContentPreferenceData(
                        id: id,
                        rect: geometry.frame(in: .named(coordinateSpace)))])
        }
    }

    // MARK: Internal

    let id: UUID
    let coordinateSpace: String
}

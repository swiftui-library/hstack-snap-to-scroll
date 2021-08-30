import Foundation
import SwiftUI

public struct GeometryReaderOverlay<ID: Hashable>: View {

    // MARK: Lifecycle

    public init(id: ID, coordinateSpace: String = "SnapToScroll") {

        self.id = id
        self.coordinateSpace = coordinateSpace
    }

    // MARK: Public

    public var body: some View {

        GeometryReader { geometry in

            Rectangle().fill(Color.clear)
                .preference(
                    key: ContentPreferenceKey.self,
                    value: [ContentPreferenceData(
                        id: id.hashValue,
                        rect: geometry.frame(in: .named(coordinateSpace)))])
        }
    }

    // MARK: Internal

    let id: ID
    let coordinateSpace: String
}

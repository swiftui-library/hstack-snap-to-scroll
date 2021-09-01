import Foundation
import SwiftUI

// MARK: - SnapAlignmentHelper

struct SnapAlignmentHelper<ID: Hashable>: ViewModifier {

    @EnvironmentObject var geometryData: GeometryEnvironment

    var id: ID
    var coordinateSpace: String?

    func body(content: Content) -> some View {

        switch geometryData.itemWidth {

        case let .some(value):

            content
                .frame(width: value)
                .overlay(GeometryReaderOverlay(id: id, coordinateSpace: coordinateSpace))

        case .none:

            content
                .overlay(GeometryReaderOverlay(id: id, coordinateSpace: coordinateSpace))
        }
    }
}

extension View {

    public func snapAlignmentHelper<ID: Hashable>(
        id: ID,
        coordinateSpace: String? = .none) -> some View {

        modifier(SnapAlignmentHelper(id: id, coordinateSpace: coordinateSpace))
    }
}

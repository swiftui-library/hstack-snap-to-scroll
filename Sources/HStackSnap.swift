import Foundation
import SwiftUI

public struct HStackSnap<Content: View>: View {

    // MARK: Lifecycle

    public init(
        alignment: SnapAlignment,
        spacing: CGFloat? = nil,
        coordinateSpace: String = "SnapToScroll",
        @ViewBuilder content: @escaping () -> Content,
        eventHandler: SnapToScrollEventHandler? = .none) {

        self.content = content
        self.alignment = alignment
        self.leadingOffset = alignment.scrollOffset
        self.spacing = spacing
        self.coordinateSpace = coordinateSpace
        self.eventHandler = eventHandler
    }

    // MARK: Public

    public var body: some View {
        
        func calculatedItemWidth(parentWidth: CGFloat, offset: CGFloat) -> CGFloat {
            return parentWidth - offset * 2
        }

        return GeometryReader { geometry in

            HStackSnapCore(
                leadingOffset: leadingOffset,
                spacing: spacing,
                coordinateSpace: coordinateSpace,
                content: content,
                eventHandler: eventHandler)
                .environmentObject(SizeOverride(itemWidth: alignment.shouldSetWidth ? calculatedItemWidth(parentWidth: geometry.size.width, offset: alignment.scrollOffset) : .none))
        }
    }

    // MARK: Internal

    var content: () -> Content

    // MARK: Private
    
    private let alignment: SnapAlignment

    /// Calculated offset based on `SnapLocation`
    private let leadingOffset: CGFloat

    private let spacing: CGFloat?

    private var eventHandler: SnapToScrollEventHandler?

    private let coordinateSpace: String
}

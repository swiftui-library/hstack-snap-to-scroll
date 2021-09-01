import Foundation
import SwiftUI

public struct HStackSnap<Content: View>: View {

    public typealias SwipeEventHandler = ((Int) -> Void)

    // MARK: Lifecycle

    public init(
        alignment: SnapAlignment,
        coordinateSpace: String = "SnapToScroll",
        @ViewBuilder content: @escaping () -> Content,
        onSwipe: SwipeEventHandler? = .none) {

        self.content = content
            self.alignment = alignment
        leadingOffset = alignment.scrollOffset
        self.coordinateSpace = coordinateSpace
        swipeEventHandler = onSwipe
    }

    // MARK: Public

    public var body: some View {
        
        func calculatedItemWidth(parentWidth: CGFloat, offset: CGFloat) -> CGFloat {
            
            print(parentWidth)
            return parentWidth - offset * 2
        }

        return GeometryReader { geometry in

            HStackSnapCore(
                leadingOffset: leadingOffset,
                coordinateSpace: coordinateSpace,
                content: content,
                onSwipe: swipeEventHandler)
                .environmentObject(SizeOverride(itemWidth: alignment.shouldSetWidth ? calculatedItemWidth(parentWidth: geometry.size.width, offset: alignment.scrollOffset) : .none))
        }
    }

    // MARK: Internal

    var content: () -> Content

    // MARK: Private
    
    private let alignment: SnapAlignment

    /// Calculated offset based on `SnapLocation`
    private let leadingOffset: CGFloat

    private var swipeEventHandler: SwipeEventHandler?

    private let coordinateSpace: String
}

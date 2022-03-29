import Foundation
import SwiftUI

public typealias SnapToScrollEventHandler = ((SnapToScrollEvent) -> Void)

// MARK: - HStackSnapCore

public struct HStackSnapCore<Content: View>: View {
    // MARK: Lifecycle

    public init(
        leadingOffset: CGFloat,
        spacing: CGFloat? = nil,
        coordinateSpace: String = "SnapToScroll",
        @ViewBuilder content: @escaping () -> Content,
        eventHandler: SnapToScrollEventHandler? = .none) {
            
        self.content = content
        self.targetOffset = leadingOffset
        self.spacing = spacing
        self.scrollOffset = leadingOffset
        self.coordinateSpace = coordinateSpace
        self.eventHandler = eventHandler
    }

    // MARK: Public

    public var body: some View {
        GeometryReader { geometry in

            HStack {
                HStack(spacing: spacing, content: content)
                    .offset(x: scrollOffset, y: .zero)
                    .animation(.easeOut(duration: 0.2))

                Spacer()
            }
            // TODO: Make this less... janky.
            .frame(width: 10000)
            .onPreferenceChange(ContentPreferenceKey.self, perform: { preferences in

                // Calculate all values once, on render. On-the-fly calculations with GeometryReader
                // proved occasionally unstable in testing.
                if !hasCalculatedFrames {
                    let screenWidth = geometry.frame(in: .named(coordinateSpace)).width

                    var itemScrollPositions: [Int: CGFloat] = [:]

                    var frameMaxXVals: [CGFloat] = []

                    for (index, preference) in preferences.enumerated() {
                        itemScrollPositions[index] = scrollOffset(for: preference.rect.minX)
                        frameMaxXVals.append(preference.rect.maxX)
                    }

                    // Array of content widths from currentElement.minX to lastElement.maxX
                    var contentFitMap: [CGFloat] = []

                    // Calculate content widths (used to trim snap positions later)
                    for currMinX in preferences.map({ $0.rect.minX }) {
                        guard let maxX = preferences.last?.rect.maxX else { break }
                        let widthToEnd = maxX - currMinX

                        contentFitMap.append(widthToEnd)
                    }

                    var frameTrim: Int = 0
                    let reversedFitMap = Array(contentFitMap.reversed())

                    // Calculate how many snap locations should be trimmed.
                    for i in 0 ..< reversedFitMap.count {
                        if reversedFitMap[i] > screenWidth {
                            frameTrim = max(i - 1, 0)
                            break
                        }
                    }

                    // Write valid snap locations to state.
                    for (i, item) in itemScrollPositions.sorted(by: { $0.value > $1.value })
                        .enumerated()
                    {
                        guard i < (itemScrollPositions.count - frameTrim) else { break }

                        snapLocations[item.key] = item.value
                    }

                    hasCalculatedFrames = true
                    
                    eventHandler?(.didLayout(layoutInfo: itemScrollPositions))
                }
            })
            .gesture(snapDrag)
        }
        .coordinateSpace(name: coordinateSpace)
    }

    // MARK: Internal

    var content: () -> Content

    var snapDrag: some Gesture {
        DragGesture()
            .onChanged { gesture in

                self.scrollOffset = gesture.translation.width + prevScrollOffset
            }.onEnded { _ in

                let currOffset = scrollOffset
                var closestSnapLocation: CGFloat = snapLocations.first?.value ?? targetOffset

                // Calculate closest snap location
                for (_, offset) in snapLocations {
                    if abs(offset - currOffset) < abs(closestSnapLocation - currOffset) {
                        closestSnapLocation = offset
                    }
                }

                // Handle swipe callback
                let selectedIndex = snapLocations.map { $0.value }.sorted(by: { $0 > $1 })
                    .firstIndex(of: closestSnapLocation) ?? 0

                if selectedIndex != previouslySentIndex {
                    eventHandler?(.swipe(index: selectedIndex))
                    previouslySentIndex = selectedIndex
                }

                // Update state
                scrollOffset = closestSnapLocation
                prevScrollOffset = scrollOffset
            }
    }

    func scrollOffset(for x: CGFloat) -> CGFloat {
        return (targetOffset * 2) - x
    }

    // MARK: Private

    @State private var hasCalculatedFrames: Bool = false

    /// Current scroll offset.
    @State private var scrollOffset: CGFloat

    /// Stored offset of previous scroll, so scroll state is resumed between drags.
    @State private var prevScrollOffset: CGFloat = 0

    /// Calculated offset based on `SnapLocation`
    @State private var targetOffset: CGFloat

    /// Space between content views`
    @State private var spacing: CGFloat?

    /// The original offset of each frame, used to calculate `scrollOffset`
    @State private var snapLocations: [Int: CGFloat] = [:]

    private var eventHandler: SnapToScrollEventHandler?

    @State private var previouslySentIndex: Int = 0

    private let coordinateSpace: String
}

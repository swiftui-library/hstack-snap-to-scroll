import Foundation
import SwiftUI

public struct HStackSnap<Content: View>: View {

    // MARK: Lifecycle

    public init(
        leadingOffset: CGFloat,
        coordinateSpace: String = "SnapToScroll",
        @ViewBuilder content: @escaping () -> Content) {

        self.content = content
        targetOffset = leadingOffset
        scrollOffset = leadingOffset
        self.coordinateSpace = coordinateSpace
    }

    // MARK: Public

    public var body: some View {

        GeometryReader { geometry in

            HStack {
                
                HStack(content: content)
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

                    let viewWidth = geometry.frame(in: .named(coordinateSpace)).width

                    var itemScrollPositions: [Int: CGFloat] = [:]

                    var frameMaxXVals: [CGFloat] = []

                    for pref in preferences {

                        itemScrollPositions[pref.id.hashValue] = scrollOffset(for: pref.rect.minX)
                        frameMaxXVals.append(pref.rect.maxX)
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

                        if reversedFitMap[i] > viewWidth {

                            frameTrim = max(i - 1, 0)
                            break
                        }
                    }

                    // Write valid snap locations to state.
                    for (i, item) in itemScrollPositions.sorted(by: { $0.value > $1.value })
                        .enumerated() {

                        guard i < (itemScrollPositions.count - frameTrim) else { break }

                        snapLocations[item.key] = item.value
                    }

                    hasCalculatedFrames = true
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

            }.onEnded { event in

                let currOffset = scrollOffset
                var closestSnapLocation: CGFloat = snapLocations.first?.value ?? targetOffset

                for (_, offset) in snapLocations {

                    if abs(offset - currOffset) < abs(closestSnapLocation - currOffset) {

                        closestSnapLocation = offset
                    }
                }

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

    /// The original offset of each frame, used to calculate `scrollOffset`
    @State private var snapLocations: [Int: CGFloat] = [:]

    private let coordinateSpace: String
}

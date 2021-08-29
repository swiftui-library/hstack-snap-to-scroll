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

            ScrollView(.horizontal) {

                HStack(content: content)
                    .frame(maxWidth: .infinity)
                    .offset(x: scrollOffset, y: .zero)
            }
            .onPreferenceChange(ContentPreferenceKey.self, perform: { preferences in

                for pref in preferences {

                    itemFrames[pref.id.hashValue] = pref
                }

            })
            .disabled(true)
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

                guard var closestFrame: ContentPreferenceData = itemFrames.first?.value else { return }

                for (_, value) in itemFrames {

                    let currDistance = distanceToTarget(
                        x: closestFrame.rect.minX)
                    let newDistance = distanceToTarget(x: value.rect.minX)

                    if abs(newDistance) < abs(currDistance) {

                        closestFrame = value
                    }
                }

                withAnimation(.easeOut(duration: 0.2)) {

                    scrollOffset += distanceToTarget(
                        x: closestFrame.rect.minX)
                }

                prevScrollOffset = scrollOffset
            }
    }

    func distanceToTarget(x: CGFloat) -> CGFloat {

        return targetOffset - x
    }

    // MARK: Private

    /// Current scroll offset.
    @State private var scrollOffset: CGFloat

    /// Stored offset of previous scroll, so scroll state is resumed between drags.
    @State private var prevScrollOffset: CGFloat = 0

    /// Calculated offset based on `SnapLocation`
    @State private var targetOffset: CGFloat

    @State private var itemFrames: [Int: ContentPreferenceData] = [:]

    private let coordinateSpace: String
}

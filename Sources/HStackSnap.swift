import Foundation
import SwiftUI

public struct HStackSnap<Content: View>: View {

    // MARK: Lifecycle

    public init(@ViewBuilder content: @escaping () -> Content) {

        self.content = content
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

                    itemFrames[pref.id] = pref
                }
            })
            .disabled(true)
            .gesture(snapDrag)
        }
            .coordinateSpace(name: ContentPreferenceKey.coordinateSpace)
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
    @State private var scrollOffset: CGFloat = 0
    
    /// Stored offset of previous scroll, so scroll state is resumed between drags.
    @State private var prevScrollOffset: CGFloat = 0
    
    ///
    @State private var targetOffset: CGFloat = 0

    @State private var itemFrames: [UUID: ContentPreferenceData] = [:]
}

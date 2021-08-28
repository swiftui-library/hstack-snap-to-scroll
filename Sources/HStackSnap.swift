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
//                        print(pref.rect.minX)
                }
            })
            .coordinateSpace(name: ContentPreferenceKey.coordinateSpace)
            .disabled(true)
            .gesture(

                DragGesture()
                    .onChanged { gesture in

                        self.scrollOffset = gesture.translation.width + prevScrollOffset

                    }.onEnded { event in

//                    scrollOffset += event.translation.width
//                    dragOffset = 0

                        guard var closestFrame: ContentPreferenceData = itemFrames.first?.value else { return }

                        func distanceToFrame(x: CGFloat, absolute: Bool) -> CGFloat {

                            if absolute {
                                return abs(targetOffset - x)
                            } else {
                                return targetOffset - x
                            }
                        }

                        for (key, value) in itemFrames {

                            let currDistance = distanceToFrame(
                                x: closestFrame.rect.minX,
                                absolute: true)
                            let newDistance = distanceToFrame(x: value.rect.minX, absolute: true)

                            print("~~ \(value.rect.maxX)")

                            if newDistance < currDistance {

                                closestFrame = value
                            }
                        }

                        withAnimation {

                            print(distanceToFrame(x: closestFrame.rect.minX, absolute: false))

                            scrollOffset += distanceToFrame(
                                x: closestFrame.rect.minX,
                                absolute: false)
                        }

                    })
            .onTapGesture {

                scrollOffset = 0
                prevScrollOffset = 0
            }
        }
    }

    // MARK: Internal

    var content: () -> Content

    // MARK: Private

    @State private var scrollOffset: CGFloat = 0
    @State private var prevScrollOffset: CGFloat = 0

    @State private var targetOffset: CGFloat = 0

    @State private var itemFrames: [UUID: ContentPreferenceData] = [:]
}

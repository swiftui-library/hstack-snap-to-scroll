import Foundation
import SwiftUI

public enum SnapToScrollEvent {
    
    /// Swiped to index.
    case swipe(index: Int)
    
    /// HStackSnap completed layout calculations. (item index, item leading offset)
    case didLayout(layoutInfo: [Int: CGFloat])
}

import Foundation
import SwiftUI

public enum SnapAlignment {

    case leading(CGFloat)
    case center(CGFloat)
    
    internal var scrollOffset: CGFloat {
        
        switch self {
            
        case let .leading(offset): return offset
        case let .center(offset): return offset
        }
    }
    
    internal var shouldSetWidth: Bool {
        
        switch self {
            
        case .leading: return false
        case .center: return true
        }
    }
}

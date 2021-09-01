import Foundation
import SwiftUI

class GeometryEnvironment: ObservableObject {

    init(itemWidth: CGFloat?) {
        
        self.itemWidth = itemWidth
    }
    
    var itemWidth: CGFloat?
}

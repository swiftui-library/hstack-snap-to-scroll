import Foundation
import SwiftUI

class SizeOverride: ObservableObject {

    init(itemWidth: CGFloat?) {
        
        self.itemWidth = itemWidth
    }
    
    var itemWidth: CGFloat?
}

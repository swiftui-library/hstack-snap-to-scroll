import Foundation
import SwiftUI

struct TagModel: Identifiable {

    // For testing purposes
    static let exampleModels: [TagModel] = [
        .init(id: 1, systemImage: "car", label: "Car", timeEstimate: 19),
        .init(id: 2, systemImage: "tram", label: "Tram", timeEstimate: 32),
        .init(id: 3, systemImage: "bus", label: "Bus", timeEstimate: 34),
        .init(id: 4, systemImage: "figure.walk", label: "Walking", timeEstimate: 59),
    ]

    let id: Int
    let systemImage: String
    let label: String
    let timeEstimate: TimeInterval
}

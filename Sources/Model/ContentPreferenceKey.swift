import Foundation
import SwiftUI

// MARK: - ExerciseEditorCellPreferenceData

struct ContentPreferenceData: Equatable {

    let id: UUID
    let rect: CGRect
}

// MARK: - ExerciseEditorCellPreferenceKey

struct ContentPreferenceKey: PreferenceKey {

    typealias Value = [ContentPreferenceData]

    // MARK: Internal

    static var defaultValue: [ContentPreferenceData] = []

    static var coordinateSpace: String = "ContentPreferenceKey"

    static func reduce(
        value: inout Value,
        nextValue: () -> Value) {

            value.append(contentsOf: nextValue())
    }
}

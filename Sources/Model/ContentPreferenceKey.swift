import Foundation
import SwiftUI

// MARK: - ExerciseEditorCellPreferenceData

struct ContentPreferenceData: Equatable {

    let id: Int
    let rect: CGRect
}

// MARK: - ExerciseEditorCellPreferenceKey

struct ContentPreferenceKey: PreferenceKey {

    typealias Value = [ContentPreferenceData]

    // MARK: Internal

    static var defaultValue: [ContentPreferenceData] = []

    static func reduce(
        value: inout Value,
        nextValue: () -> Value) {

            value.append(contentsOf: nextValue())
    }
}

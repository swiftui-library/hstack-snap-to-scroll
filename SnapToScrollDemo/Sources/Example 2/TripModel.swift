import Foundation

// MARK: - TripModel

struct TripModel {

    static let newYork: TripModel = .init(
        imageName: "NewYork",
        destination: "New York",
        startingPrice: 1230)
    static let newOrleans: TripModel = .init(
        imageName: "NewOrleans",
        destination: "New Orleans",
        startingPrice: 1850)
    static let venice: TripModel = .init(
        imageName: "Venice",
        destination: "Venice",
        startingPrice: 2340)
    static let london: TripModel = .init(
        imageName: "London",
        destination: "London",
        startingPrice: 2200)
    static let mtFuji: TripModel = .init(
        imageName: "MtFuji",
        destination: "Mt. Fuji",
        startingPrice: 2900)
    static let egypt: TripModel = .init(
        imageName: "Egypt",
        destination: "Egypt",
        startingPrice: 2450)

    let imageName: String
    let destination: String
    let startingPrice: Double
}

// MARK: - TripModelTuple

struct TripTupleModel: Identifiable {

    static let exampleModels: [TripTupleModel] = [
        .init(id: 0, trip1: TripModel.newYork, trip2: TripModel.newOrleans),
        .init(id: 1, trip1: TripModel.venice, trip2: TripModel.london),
        .init(id: 2, trip1: TripModel.mtFuji, trip2: TripModel.egypt),
    ]

    let id: Int
    let trip1: TripModel
    let trip2: TripModel
}

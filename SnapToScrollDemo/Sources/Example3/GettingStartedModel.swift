import Foundation

struct GettingStartedModel: Identifiable {
    
    static let exampleModels: [GettingStartedModel] = [
        .init(id: 0, systemImage: "camera.aperture", title: "Snap a Pic", body: "We feature the viewfinder front and center in this throwback app."),
        .init(id: 1, systemImage: "camera.filters", title: "Filter it Up", body: "Add filters - from detailed colorization to film effects."),
        .init(id: 2, systemImage: "paperplane", title: "Send It", body: "Share your photos with your contacts. Or the entire world."),
        .init(id: 3, systemImage: "sparkles", title: "Be Awesome", body: "You're clearly already doing this. Just wanted to remind you. 😉")
    ]
    
    let id: Int
    let systemImage: String
    let title: String
    let body: String
}

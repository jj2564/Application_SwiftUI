
import ComposableArchitecture
import SwiftUI

@main
struct BaseApplication: App {
    var body: some Scene {
        WindowGroup {
            AppView(store: .init(
                initialState: AppFeature.State(),
                reducer: { AppFeature() }
            ))
        }
    }
}

struct AppFeature: Reducer {
    struct State: Equatable {}

    enum Action {
        case scenePhaseBecomeActive
    }

    func reduce(into _: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .scenePhaseBecomeActive:
            return .send(.scenePhaseBecomeActive)
        }
    }
}


struct AppView: View {
    let store: StoreOf<AppFeature>
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        Text("Appliction")
            .onChange(of: scenePhase) { newValue in
                switch newValue {
                case .active:
                    store.send(.scenePhaseBecomeActive)
                default: return
                }
            }
    }
}

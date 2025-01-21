import ComposableArchitecture
import AppEnvironment

@Reducer
struct AppFeature {
    @ObservableState
    struct State: Equatable { }

    enum Action: Equatable {
        case scenePhaseBecomeActive
        case checkUserEnableNotification
        case userEnableNotification(Bool)
    }

//    @Dependency(\.systemService) var systemService
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .scenePhaseBecomeActive:
                return .send(.checkUserEnableNotification)
            case .checkUserEnableNotification:
                return .run { send in
//                    let isEnabled = await systemService.checkUserEnableNotification("id")
                    await send(.userEnableNotification(true))
                }
            case .userEnableNotification(_):
                return .none
            }
        }
    }
}

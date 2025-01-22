import ComposableArchitecture
import AppEnvironments

@Reducer
public struct AppFeature: Sendable {
    @ObservableState
    public struct State: Equatable {
        public var isEnableUserNotification: Bool = false
    }

    public enum Action: Equatable {
        case scenePhaseBecomeActive
        case checkUserEnableNotification
        case userEnableNotification(Bool)
    }

    @Dependency(\.systemService) var systemService
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .scenePhaseBecomeActive:
                return .send(.checkUserEnableNotification)
            case .checkUserEnableNotification:
                return .run { send in
                    let isEnabled = await systemService.checkUserEnableNotification("id")
                    await send(.userEnableNotification(isEnabled))
                }
            case let .userEnableNotification(isEnabled):
                state.isEnableUserNotification = isEnabled
                return .none
            }
        }
    }
}

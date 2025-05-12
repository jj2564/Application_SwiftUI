//
//  AppFeatures.swift
//  AppMain
//
//  Created by IrvingHuang on 2025/5/12.
//

import ComposableArchitecture
import AppEnvironments
import SwiftUI

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

struct AppView: View {
    let store: StoreOf<AppFeature>
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        WithViewStore(store, observe: { $0.isEnableUserNotification } ) { viewStore in
            let isEnable = viewStore.state
            
            Text("Notification is \(isEnable)")
                .onChange(of: scenePhase) { newValue in
                    switch newValue {
                    case .active:
                        store.send(.scenePhaseBecomeActive)
                    case .background, .inactive:
                        break
                    default: return
                    }
                }
        }
    }
}


#Preview {
    AppView(store: .init(
        initialState: AppFeature.State(),
        reducer: { AppFeature() }
    ))
}

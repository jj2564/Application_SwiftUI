//
//  AppMainTests.swift
//  AppMain
//
//  Created by IrvingHuang on 2025/5/12.
//

import ComposableArchitecture
@testable import AppMain
import Testing

@MainActor
struct ApplicationTests {
    
    @Test
    func appBecomeActive() async {
        let store = TestStore(initialState: AppFeature.State()) {
            AppFeature()
        } withDependencies: {
            $0.systemService.checkUserEnableNotification =  { _ in true }
        }
        
        await store.send(.scenePhaseBecomeActive)
        await store.receive(.checkUserEnableNotification)
        await store.receive(.userEnableNotification(true)) {
            $0.isEnableUserNotification = true
        }
    }
}


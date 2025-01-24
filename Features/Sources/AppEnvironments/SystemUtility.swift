//
//  SystemUtility.swift
//  Features
//
//  Created by IrvingHuang on 2025/1/24.
//

import Foundation

class SystemUtility {
    
    enum Site: String {
        case PROD
        case DEV
    }
    
    static func info<T>(forKey key: String) -> T? {
        Bundle.main.infoDictionary?[key] as? T
    }
    
    static let appVersion: String = info(forKey: "CFBundleShortVersionString") ?? ""
    
    static let appSite: Site = Site(rawValue: info(forKey: "APP_ENVIRONMENT_SITE") ?? "DEV")!

    static let mobileDeviceModelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        return machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
    }()
}

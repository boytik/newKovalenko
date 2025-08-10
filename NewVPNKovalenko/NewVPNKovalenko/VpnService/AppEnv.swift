
import Foundation

enum PrefsKey {
    static let autoConnect = "auto_connect"
}

enum ConfigFiles {
    static let xray = "xray_config.json"
}

enum AppEnv {
    static let appGroupID = "group.com.mycompany.myvpn"
    static var containerURL: URL {
        guard let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupID) else {
            fatalError("App Group not configured correctly: \(appGroupID)")
        }
        return url
    }

    static var sharedDefaults: UserDefaults {
        guard let ud = UserDefaults(suiteName: appGroupID) else {
            fatalError("Cannot create UserDefaults for app group: \(appGroupID)")
        }
        return ud
    }
}



extension AppEnv {
    static var isAutoConnectEnabled: Bool {
        get { sharedDefaults.bool(forKey: PrefsKey.autoConnect) }
        set { sharedDefaults.set(newValue, forKey: PrefsKey.autoConnect) }
    }
}

extension AppEnv {
    static var hasXrayConfig: Bool {
        FileManager.default.fileExists(atPath: containerURL.appendingPathComponent(ConfigFiles.xray).path)
    }
}



import Foundation

struct VLESSConfig: Codable {
    var address: String
    var port: Int
    var uuid: String
    var flow: String
    var security: String
    var sni: String
    var publicKey: String
    var shortId: String
    var spx: String
}

final class VLESSService {
    static let shared = VLESSService()
    private init() {}

    func parse(link: String) -> VLESSConfig? {
        guard let url = URL(string: link.replacingOccurrences(of: "vless://", with: "https://")) else {
            return nil
        }
        let uuid = url.user ?? ""
        let address = url.host ?? ""
        let port = url.port ?? 443

        let queryItems = URLComponents(string: link.replacingOccurrences(of: "vless://", with: "https://"))?.queryItems
        func get(_ name: String) -> String {
            queryItems?.first(where: { $0.name == name })?.value ?? ""
        }

        return VLESSConfig(
            address: address,
            port: port,
            uuid: uuid,
            flow: get("flow"),
            security: get("security"),
            sni: get("sni"),
            publicKey: get("pbk"),
            shortId: get("sid"),
            spx: get("spx")
        )
    }

    func generateXrayConfig(from config: VLESSConfig) -> [String: Any] {
        [
            "inbounds": [],
            "outbounds": [[
                "protocol": "vless",
                "settings": [
                    "vnext": [[
                        "address": config.address,
                        "port": config.port,
                        "users": [[
                            "id": config.uuid,
                            "flow": config.flow,
                            "encryption": "none"
                        ]]
                    ]]
                ],
                "streamSettings": [
                    "security": config.security,
                    "realitySettings": [
                        "serverName": config.sni,
                        "publicKey": config.publicKey,
                        "shortId": config.shortId,
                        "spiderX": config.spx
                    ]
                ]
            ]]
        ]
    }

    @discardableResult
    func saveConfigToAppGroup(json: [String: Any], filename: String = "xray_config.json") -> URL? {
        let fileURL = AppEnv.containerURL.appendingPathComponent(filename)
        do {
            if FileManager.default.fileExists(atPath: fileURL.path) {
                try FileManager.default.removeItem(at: fileURL)
            }
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            try data.write(to: fileURL)
            return fileURL
        } catch {
            print("❌ Failed to save config: \(error)")
            return nil
        }
    }
}


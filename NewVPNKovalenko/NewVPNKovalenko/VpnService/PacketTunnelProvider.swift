


//import NetworkExtension
//
//final class PacketTunnelProvider: NEPacketTunnelProvider {
//
//    var xrayProcess: Process?
//
//    override func startTunnel(options: [String : NSObject]?, completionHandler: @escaping (Error?) -> Void) {
//
//        // 🔗 Путь к App Group
//        guard let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.YOUR_APP_GROUP_ID") else {
//            completionHandler(NSError(domain: "AppGroup", code: 0, userInfo: [NSLocalizedDescriptionKey: "App Group not found"]))
//            return
//        }
//
//        let configPath = containerURL.appendingPathComponent("xray_config.json").path
//
//        // 📦 Путь к xray внутри расширения
//        guard let xrayPath = Bundle.main.path(forResource: "xray", ofType: nil) else {
//            completionHandler(NSError(domain: "Xray", code: 0, userInfo: [NSLocalizedDescriptionKey: "xray binary not found in bundle"]))
//            return
//        }
//
//        // 🚀 Настройка процесса
//        let process = Process()
//        process.launchPath = xrayPath
//        process.arguments = ["-c", configPath]
//
//        // (Опционально) Логирование stdout/stderr
//        let outputPipe = Pipe()
//        process.standardOutput = outputPipe
//        process.standardError = outputPipe
//
//        outputPipe.fileHandleForReading.readabilityHandler = { handle in
//            let data = handle.availableData
//            if let line = String(data: data, encoding: .utf8) {
//                NSLog("[xray] \(line.trimmingCharacters(in: .newlines))")
//            }
//        }
//
//        do {
//            try process.run()
//            self.xrayProcess = process
//            completionHandler(nil)
//        } catch {
//            completionHandler(error)
//        }
//    }
//
//    override func stopTunnel(with reason: NEProviderStopReason, completionHandler: @escaping () -> Void) {
//        xrayProcess?.terminate()
//        xrayProcess = nil
//        completionHandler()
//    }
//}


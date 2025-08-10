//
//
//

import NetworkExtension
import Foundation

final class PacketTunnelProvider: NEPacketTunnelProvider {

    private let engine = XRayEngineWrapper()
    private var running = false

    override func startTunnel(options: [String : NSObject]? = nil,
                              completionHandler: @escaping (Error?) -> Void) {

        let name = (protocolConfiguration as? NETunnelProviderProtocol)?
            .providerConfiguration?["configFile"] as? String ?? "xray_config.json"
        let url = AppEnv.containerURL.appendingPathComponent(name)

        guard let data = try? Data(contentsOf: url),
              let json = String(data: data, encoding: .utf8) else {
            return completionHandler(NSError(domain: "Tunnel", code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Config not found or invalid"]))
        }

        let settings = NEPacketTunnelNetworkSettings(tunnelRemoteAddress: "127.0.0.1")
        settings.mtu = 1500
        let ipv4 = NEIPv4Settings(addresses: ["10.0.0.2"], subnetMasks: ["255.255.255.0"])
        ipv4.includedRoutes = [NEIPv4Route.default()]
        settings.ipv4Settings = ipv4
        let dns = NEDNSSettings(servers: ["1.1.1.1","8.8.8.8"])
        dns.matchDomains = [""]
        settings.dnsSettings = dns

        setTunnelNetworkSettings(settings) { [weak self] error in
            guard let self = self else { return }
            if let error { return completionHandler(error) }

            do {
                try self.engine.start(with: json, provider: self)
            } catch {
                return completionHandler(error)
            }

            self.running = true
            self.readLoop()
            completionHandler(nil)
        }
    }

    override func stopTunnel(with reason: NEProviderStopReason,
                             completionHandler: @escaping () -> Void) {
        running = false
        engine.stop()
        completionHandler()
    }

    private func readLoop() {
        func step() {
            packetFlow.readPackets { [weak self] packets, _ in
                guard let self = self, self.running else { return }
                for p in packets { self.engine.feed(packet: p) }
                step()
            }
        }
        step()
    }
}

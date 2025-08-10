
import Foundation
import NetworkExtension

final class VPNManager {
    static let shared = VPNManager()
    private init() {}

    private let tunnelBundleID = "Boytik.NewVPNKovalenko.KovalenkoPacketTunnel"

    private var manager: NETunnelProviderManager?

    func loadOrCreate(completion: @escaping (Result<NETunnelProviderManager, Error>) -> Void) {
        NETunnelProviderManager.loadAllFromPreferences { [weak self] (managers, error) in
            if let error = error { return completion(.failure(error)) }
            if let existing = managers?.first {
                self?.manager = existing
                return completion(.success(existing))
            }

            let m = NETunnelProviderManager()
            let proto = NETunnelProviderProtocol()
            proto.providerBundleIdentifier = self?.tunnelBundleID
            proto.serverAddress = "127.0.0.1"
            proto.providerConfiguration = ["configFile": "xray_config.json"]

            m.protocolConfiguration = proto
            m.localizedDescription = "Kovalenko VPN"
            m.isEnabled = true

            m.saveToPreferences { err in
                if let err = err { return completion(.failure(err)) }
                m.loadFromPreferences { err in
                    if let err = err { return completion(.failure(err)) }
                    self?.manager = m
                    completion(.success(m))
                }
            }
        }
    }

    func connect(completion: @escaping (String?) -> Void) {
        loadOrCreate { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let e):
                completion(self.humanize(e as NSError))
            case .success(let m):
                do {
                    try m.connection.startVPNTunnel(options: nil)
                    completion(nil)
                } catch let e as NSError {
                    completion(self.humanize(e))
                }
            }
        }
    }

    func disconnect() { manager?.connection.stopVPNTunnel() }

    var status: NEVPNStatus { manager?.connection.status ?? .invalid }

    func observeStatus(_ handler: @escaping (NEVPNStatus) -> Void) -> NSObjectProtocol {
        NotificationCenter.default.addObserver(
            forName: .NEVPNStatusDidChange, object: nil, queue: .main
        ) { [weak self] _ in handler(self?.status ?? .invalid) }
    }

    private func humanize(_ err: NSError) -> String {
        if err.domain == NEVPNErrorDomain,
           let code = NEVPNError.Code(rawValue: err.code) {
            switch code {
            case .configurationInvalid:
                return "Конфигурация VPN недействительна. Часто это из-за отсутствия entitlement для Network Extension."
            case .configurationDisabled:
                return "VPN конфигурация выключена."
            case .connectionFailed:
                return "Не удалось установить подключение."
            case .configurationStale:
                return "Конфигурация устарела. Повторная запись."
            case .configurationReadWriteFailed:
                return "Ошибка сохранения конфигурации."
            default:
                break
            }
        }
        return err.localizedDescription
    }
}


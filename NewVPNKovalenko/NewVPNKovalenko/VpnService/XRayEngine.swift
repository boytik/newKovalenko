
import Foundation
import NetworkExtension
import XrayBridge   // модуль с большой B

final class XRayEngineWrapper: NSObject {

    // Конформимся к ПРОТОКОЛУ, обратим внимание на суффикс Protocol
    final class Writer: NSObject, XraybridgeMobileWriterProtocol {
        weak var provider: NEPacketTunnelProvider?

        init(provider: NEPacketTunnelProvider) { self.provider = provider }

        // Сигнатура должна совпасть с протоколом.
        // Если Xcode попросит Data! — поменяй на Data! (зависит от генерации)
        func writePacket(_ p: Data?) {
            guard let provider, let p else { return }
            provider.packetFlow.writePackets([p], withProtocols: [AF_INET as NSNumber])
        }
    }

    private var writer: Writer?

    func start(with configJSON: String, provider: NEPacketTunnelProvider) throws {
        let w = Writer(provider: provider)
        var nsError: NSError?
        // Имена функций с маленькой b и 3-й параметр — NSErrorPointer
        XraybridgeStart(configJSON, w, &nsError)
        if let nsError { throw nsError }
        writer = w
    }

    func feed(packet: Data) {
        XraybridgeFeedPacket(packet)
    }

    func stop() {
        XraybridgeStop()
        writer = nil
    }
}

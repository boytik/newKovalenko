
import UIKit
import NetworkExtension

final class MainViewController: UIViewController {
    let mainView: MainView = .init()
    private var statusObserver: NSObjectProtocol?

    override func loadView() { self.view = mainView }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = UIColor(named: "bg")
        progress()

        mainView.settingbutton.addTarget(self, action: #selector(goToSetting), for: .touchUpInside)
        mainView.serversButton.addTarget(self, action: #selector(goToServers), for: .touchUpInside)
        mainView.startButton.addTarget(self, action: #selector(toggleVPN), for: .touchUpInside)

        mainView.autoConnectSwitch.isOn = AppEnv.isAutoConnectEnabled
        mainView.autoConnectSwitch.addTarget(self, action: #selector(autoConnectChanged(_:)), for: .valueChanged)

        statusObserver = VPNManager.shared.observeStatus { [weak self] status in
            self?.applyStatus(status)
        }

        applyStatus(VPNManager.shared.status)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if AppEnv.isAutoConnectEnabled, AppEnv.hasXrayConfig {
            connectIfNeeded()
        }
    }

    deinit {
        if let o = statusObserver { NotificationCenter.default.removeObserver(o) }
    }

    // MARK: UI state by status
    private func applyStatus(_ status: NEVPNStatus) {
        switch status {
        case .connecting:
            mainView.startButton.isEnabled = false
            mainView.speedLabel.text = "…"
        case .connected:
            mainView.startButton.isEnabled = true
            mainView.speedLabel.text = "ON"
        case .disconnecting:
            mainView.startButton.isEnabled = false
        case .disconnected, .invalid:
            mainView.startButton.isEnabled = true
            mainView.speedLabel.text = "OFF"
        case .reasserting:
            mainView.startButton.isEnabled = false
        @unknown default:
            mainView.startButton.isEnabled = true
        }
    }

    // MARK: Actions
    @objc func goToSetting() {
        navigationController?.pushViewController(SettingsViewController(), animated: true)
    }

    @objc func goToServers() {
        navigationController?.pushViewController(ServersViewController(), animated: true)
    }

    @objc private func autoConnectChanged(_ sender: UIControl) {
        let on = (sender as? UISwitch)?.isOn ?? AppEnv.isAutoConnectEnabled
        AppEnv.isAutoConnectEnabled = on
        if on { connectIfNeeded() }
    }

    @objc private func toggleVPN() {
        switch VPNManager.shared.status {
        case .connected, .connecting, .reasserting:
            VPNManager.shared.disconnect()
        default:
            connectIfNeeded()
        }
    }

    private func connectIfNeeded() {
        guard AppEnv.hasXrayConfig else {
            presentAlert(title: "Нет конфигурации", message: "Сначала добавь ключ на экране Settings.")
            return
        }
        VPNManager.shared.connect { [weak self] message in
            if let message {                    
                self?.presentAlert(title: "Не удалось подключиться", message: message)
            }
        }
    }


    // MARK: misc
    func progress() {
        mainView.speedFillView.startAngleDeg = 121
        mainView.speedFillView.endAngleDeg = 421
        mainView.speedFillView.innerRadiusRatio = 0.80
        mainView.speedFillView.progress = 0.6
    }

    private func presentAlert(title: String, message: String) {
        let a = UIAlertController(title: title, message: message, preferredStyle: .alert)
        a.addAction(UIAlertAction(title: "OK", style: .default))
        present(a, animated: true)
    }
}


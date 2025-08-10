

import Foundation
import UIKit

final class SettingsViewController: UIViewController {
    let mainView: SettingsView = .init()

    override func loadView() { view = mainView }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true

        mainView.textField.autocorrectionType = .no
        mainView.textField.autocapitalizationType = .none
        mainView.textField.keyboardType = .URL
        mainView.textField.returnKeyType = .done

        mainView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        mainView.firstButton.addTarget(self, action: #selector(addKeyTapped), for: .touchUpInside)
        mainView.secondButton.addTarget(self, action: #selector(openTelegramBot), for: .touchUpInside)

        if let saved = AppEnv.sharedDefaults.string(forKey: "vless_link") {
            mainView.textField.text = saved
        }
    }

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func openTelegramBot() {
        if let tgURL = URL(string: "tg://resolve?domain=Kovalenkovpn_bot"),
           UIApplication.shared.canOpenURL(tgURL) {
            UIApplication.shared.open(tgURL)
        } else if let webURL = URL(string: "https://t.me/Kovalenkovpn_bot") {
            UIApplication.shared.open(webURL)
        }
    }

    @objc private func addKeyTapped() {
        view.endEditing(true)

        guard var link = mainView.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !link.isEmpty else {
            presentAlert(title: "Пусто", message: "Вставь VLESS-ссылку в поле.")
            return
        }
        if !link.lowercased().hasPrefix("vless://") { link = "vless://\(link)" }

        guard let vless = VLESSService.shared.parse(link: link) else {
            presentAlert(title: "Ошибка", message: "Не удалось разобрать ссылку. Формат: vless://...")
            return
        }

        let json = VLESSService.shared.generateXrayConfig(from: vless)
        guard let fileURL = VLESSService.shared.saveConfigToAppGroup(json: json) else {
            presentAlert(title: "Ошибка", message: "Не удалось сохранить конфиг в App Group.")
            return
        }

        AppEnv.sharedDefaults.set(link, forKey: "vless_link")
        presentAlert(title: "Готово", message: "Ключ сохранён.\nФайл: \(fileURL.lastPathComponent)")
    }

    private func presentAlert(title: String, message: String) {
        let a = UIAlertController(title: title, message: message, preferredStyle: .alert)
        a.addAction(UIAlertAction(title: "OK", style: .default))
        present(a, animated: true)
    }
}

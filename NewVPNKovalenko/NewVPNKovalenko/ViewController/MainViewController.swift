
import UIKit

final class MainViewController: UIViewController {
    //MARK: Properties
    let mainView: MainView = .init()
    
    //MARK: Life Cycle
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        mainView.backgroundColor = UIColor(named: "bg")
        super.viewDidLoad()
        progress()
        mainView.settingbutton.addTarget(self, action: #selector(goToSetting), for: .touchUpInside)
        mainView.serversButton.addTarget(self, action: #selector(goToServers), for: .touchUpInside)
    }
    //MARK: Methods
    
    func progress() {
        mainView.speedFillView.startAngleDeg = 121   // немного позже старт
        mainView.speedFillView.endAngleDeg = 421     // чуть короче конец
        mainView.speedFillView.innerRadiusRatio = 0.80
        mainView.speedFillView.progress = 0.6


    }
    @objc func goToSetting() {
        navigationController?.pushViewController(SettingsViewController(), animated: true)
    }
    @objc func goToServers(){
        navigationController?.pushViewController(ServersViewController(), animated: true)
    }
    
}

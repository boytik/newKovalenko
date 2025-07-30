

import Foundation
import UIKit

final class SettingsViewController: UIViewController {
    
    //MARK: Properties
    let mainView: SettingsView = .init()
    
    //MARK: Life Cycle
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        mainView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    //MARK: Methods
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

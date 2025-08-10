
import Foundation
import UIKit


final class ServersViewController: UIViewController {
    
    //MARK: Properties
    private let mainView: ServersView = .init()
    private var servers: [ServerModel] = []
    
    //MARK: Life Cycle
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        mainView.backgroundColor = UIColor(named: "bg")
        mainView.tableView.register(ServerInfoCell.self, forCellReuseIdentifier: "ServerInfoCell")
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        mainView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        loadServers()
    }

    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Load Servers
    private func loadServers() {
        servers = [
            ServerModel(serverFlagName: "flag", serverIP: "17.03.93.99", signalLevel: 5),
            ServerModel(serverFlagName: "flag", serverIP: "45.12.33.11", signalLevel: 4),
            ServerModel(serverFlagName: "flag", serverIP: "88.22.91.45", signalLevel: 3),
            ServerModel(serverFlagName: "flag", serverIP: "192.168.0.12", signalLevel: 2),
            ServerModel(serverFlagName: "flag", serverIP: "132.45.67.89", signalLevel: 1)
        ]
        
        mainView.tableView.reloadData()
    }
}

extension ServersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.075
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return servers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ServerInfoCell", for: indexPath) as? ServerInfoCell else {
            return UITableViewCell()
        }
        
        let server = servers[indexPath.row]
        
        let flagImage = UIImage(named: server.serverFlagName)
        
        cell.configure(flag: flagImage, ip: server.serverIP, signalLevel: server.signalLevel)
        
        return cell
    }
}


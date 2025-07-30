
import UIKit

final class ServersView: UIView {
    
    //MARK: Views
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Arrowback"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose a VPN Server:"
        label.font = UIFont(name: "SegoeUI", size: 24)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(named: "bg")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    lazy var addserversButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "Server"), for: .normal)
        button.setTitle("+ Add ", for: .normal)
        button.titleLabel?.font = UIFont(name: "SegoeUI", size: 17)
        button.setTitleColor(UIColor(named: "Color"), for: .normal)
        button.contentHorizontalAlignment = .center
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemTeal.cgColor
        
        button.tintColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: Init
    init() {
        super.init(frame: .zero)
        setView()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView(){
        addSubview(titleLabel)
        addSubview(backButton)
        addSubview(addserversButton)
        addSubview(tableView)
    }
    
    private func setConstraint(){
        NSLayoutConstraint.activate([
            // Кнопка назад
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            backButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.04),
            backButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.03),
            
            // Заголовок
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.03),
            
            // Кнопка "Add Server"
            addserversButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            addserversButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addserversButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.07),
            addserversButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.84),
            
            // Таблица под кнопкой
            tableView.topAnchor.constraint(equalTo: addserversButton.bottomAnchor, constant: 8),
            tableView.centerXAnchor.constraint(equalTo: centerXAnchor),
            tableView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.84),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}


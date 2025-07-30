
import UIKit



class MainView: UIView {
    
    // MARK: - Views
    lazy var settingbutton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Settings"), for: .normal)
        button.tintColor = UIColor(named: "Setting")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var titelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Titel")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var speedFillView: SpeedFillView = {
        let view = SpeedFillView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Power"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var speedLabel: UILabel = {
        let label = UILabel()
        label.text = "33"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 35, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // 🔥 Эффект свечения
        label.layer.shadowColor = UIColor.cyan.cgColor
        label.layer.shadowRadius = 6
        label.layer.shadowOpacity = 0.9
        label.layer.shadowOffset = .zero
        
        return label
    }()

    lazy var speedValue: UILabel = {
        let label = UILabel()
        label.text = "Mbit/s"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // 🔥 Эффект свечения
        label.layer.shadowColor = UIColor.cyan.cgColor
        label.layer.shadowRadius = 6
        label.layer.shadowOpacity = 0.9
        label.layer.shadowOffset = .zero
        
        return label
    }()

    
    // Session
    lazy var sessionText: UILabel = {
        let label = UILabel()
        label.text = "Session:"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "Rubik-Regular", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var timeSessionText: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "SegoeUI", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Стрелки
    lazy var arrowUp: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.up"))
        imageView.tintColor = UIColor(named: "Color")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var arrowDown: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.down"))
        imageView.tintColor = UIColor(named: "Color")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Speed labels
    lazy var speedOut: UILabel = {
        let label = UILabel()
        label.text = "92.4MB"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "SegoeUI", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var speedIn: UILabel = {
        let label = UILabel()
        label.text = "326.4MB"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "SegoeUI", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Servers
    lazy var serversButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "Server"), for: .normal)
        button.setTitle("🇫🇷 Netherlands\nip: 192.168.1.1", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Regular", size: 18)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.contentHorizontalAlignment = .center
        
        let customRightView = UIImageView(image: UIImage(systemName: "chevron.right"))
        customRightView.tintColor = .gray
        customRightView.translatesAutoresizingMaskIntoConstraints = false
        
        button.addSubview(customRightView)
        
        NSLayoutConstraint.activate([
            customRightView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            customRightView.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -10),
            customRightView.widthAnchor.constraint(equalToConstant: 24),
            customRightView.heightAnchor.constraint(equalToConstant: 24)
        ])
       
        button.tintColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var autoConnectLabel: UILabel = {
        let label = UILabel()
        label.text = "Auto connect:"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Rubik-Regular", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var autoConnectSwitch: AutoConnectSwitch = {
        let button = AutoConnectSwitch()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Init
    init() {
        super.init(frame: .zero)
        setView()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    func setView() {
        addSubview(settingbutton)
        addSubview(titelImageView)
        addSubview(speedFillView)
        addSubview(startButton)
        addSubview(speedLabel)
        addSubview(speedValue)
        addSubview(sessionText)
        addSubview(timeSessionText)
        addSubview(arrowUp)
        addSubview(speedOut)
        addSubview(arrowDown)
        addSubview(speedIn)
        addSubview(serversButton)
        addSubview(autoConnectLabel)
        addSubview(autoConnectSwitch)
    }
    
    // MARK: - Setup Constraints
    func setConstraint() {
        NSLayoutConstraint.activate([
            // Settings
            settingbutton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.03),
            settingbutton.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.03),
            settingbutton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            settingbutton.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            
            // Title
            titelImageView.topAnchor.constraint(equalTo: settingbutton.bottomAnchor, constant: 10),
            titelImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titelImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.027),
            titelImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.681),
            
            // Speedometer
            speedFillView.topAnchor.constraint(equalTo: titelImageView.bottomAnchor,
                constant: UIScreen.main.bounds.height * 0.08),
            speedFillView.centerXAnchor.constraint(equalTo: centerXAnchor),
            speedFillView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.278),
            speedFillView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.668),
            
            // ON Button
            startButton.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.14),
            startButton.heightAnchor.constraint(equalTo: startButton.widthAnchor),
            startButton.centerYAnchor.constraint(equalTo: speedFillView.centerYAnchor),
            startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            // Speed Labels
            speedLabel.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 5),
            speedLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            speedLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.061),
            speedLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.17),
            
            speedValue.topAnchor.constraint(equalTo: speedLabel.bottomAnchor, constant: 5),
            speedValue.centerXAnchor.constraint(equalTo: centerXAnchor),
            speedValue.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.025),
            speedValue.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.27),
            
            // Session text
            sessionText.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 30),
            sessionText.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.021),
            sessionText.bottomAnchor.constraint(equalTo: timeSessionText.topAnchor, constant: -10),
            sessionText.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.304),
            
            timeSessionText.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 30),
            timeSessionText.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.021),
            timeSessionText.bottomAnchor.constraint(equalTo: speedIn.topAnchor, constant: -30),
            timeSessionText.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.304),
            
            // Arrow down + speedOut aligned to session
            arrowUp.centerYAnchor.constraint(equalTo: speedOut.centerYAnchor),
            arrowUp.leadingAnchor.constraint(equalTo: sessionText.leadingAnchor),
            arrowUp.widthAnchor.constraint(equalToConstant: 14),
            arrowUp.heightAnchor.constraint(equalToConstant: 14),
            
            speedOut.leadingAnchor.constraint(equalTo: arrowUp.trailingAnchor, constant: 10),
            speedOut.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.204),
            speedOut.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.021),
            speedOut.bottomAnchor.constraint(equalTo: serversButton.topAnchor, constant: -30),
            
            // Arrow up + speedIn aligned to session
            arrowDown.centerYAnchor.constraint(equalTo: speedIn.centerYAnchor),
            arrowDown.leadingAnchor.constraint(equalTo: sessionText.leadingAnchor),
            arrowDown.widthAnchor.constraint(equalToConstant: 14),
            arrowDown.heightAnchor.constraint(equalToConstant: 14),
            
            speedIn.leadingAnchor.constraint(equalTo: arrowDown.trailingAnchor, constant: 10),
            speedIn.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.204),
            speedIn.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.021),
            speedIn.bottomAnchor.constraint(equalTo: speedOut.topAnchor, constant: -10),
            
            // Servers button
            serversButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -(UIScreen.main.bounds.height * 0.14)),
            serversButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            serversButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.07),
            serversButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.84),
            
            autoConnectLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -(UIScreen.main.bounds.width * 0.06)),
            autoConnectLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.369),
            autoConnectLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.032),
            autoConnectLabel.topAnchor.constraint(equalTo: sessionText.topAnchor),
            
            autoConnectSwitch.topAnchor.constraint(equalTo: autoConnectLabel.bottomAnchor, constant: 10),
            autoConnectSwitch.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.19),
            autoConnectSwitch.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.043),
            autoConnectSwitch.centerXAnchor.constraint(equalTo: autoConnectLabel.centerXAnchor)
        ])
    }
}






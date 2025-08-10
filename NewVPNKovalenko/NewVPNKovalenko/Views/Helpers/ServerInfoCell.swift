
import UIKit

final class ServerInfoCell: UITableViewCell {
    
    private let flagImageView = UIImageView()
    private let ipLabel = UILabel()
    private let signalStackView = UIStackView()
    private var signalBars: [UIView] = []
    private let containerView = UIView()
    
    private let mainStack = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.systemTeal.cgColor
        containerView.backgroundColor = UIColor(named: "bg")
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        flagImageView.contentMode = .scaleAspectFit
        flagImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        flagImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        ipLabel.font = UIFont(name: "SegoeUI", size: 20)
        ipLabel.textColor = .white
        
        signalStackView.axis = .horizontal
        signalStackView.alignment = .bottom
        signalStackView.spacing = 2
        signalStackView.distribution = .equalSpacing
        
        for i in 1...5 {
            let bar = UIView()
            bar.backgroundColor = UIColor.gray
            bar.layer.cornerRadius = 1
            bar.widthAnchor.constraint(equalToConstant: 2).isActive = true
            bar.heightAnchor.constraint(equalToConstant: CGFloat(i * 3)).isActive = true
            signalBars.append(bar)
            signalStackView.addArrangedSubview(bar)
        }
        
        mainStack.axis = .horizontal
        mainStack.alignment = .center
        mainStack.distribution = .fill
        mainStack.spacing = 8
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubview(flagImageView)
        mainStack.addArrangedSubview(ipLabel)
        mainStack.addArrangedSubview(signalStackView)
        signalStackView.widthAnchor.constraint(equalTo: mainStack.widthAnchor, multiplier: 0.1).isActive = true
        
        contentView.addSubview(containerView)
        containerView.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            mainStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            mainStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            mainStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15)
        ])
    }
    
    func configure(flag: UIImage?, ip: String, signalLevel: Int) {
        flagImageView.image = flag
        ipLabel.text = ip
        
        for (index, bar) in signalBars.enumerated() {
            bar.backgroundColor = (index < signalLevel) ? UIColor(named: "Color") : UIColor.gray
        }
    }
}




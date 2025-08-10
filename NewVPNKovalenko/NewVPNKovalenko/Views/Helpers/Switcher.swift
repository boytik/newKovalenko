

import UIKit

class AutoConnectSwitch: UIButton {
    
    var isOn = false
    
    private let onBackground = UIImage(named: "PickerOn")
    private let offBackground = UIImage(named: "PickerOff")
    
    private let onIcon = UIImage(named: "Gasstationactive") 
    private let offIcon = UIImage(named: "Gasstation")
    
    private let iconView = UIImageView()
    
    private var iconLeadingConstraint: NSLayoutConstraint!
    private var iconTrailingConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        setBackgroundImage(offBackground, for: .normal)

        iconView.image = offIcon
        iconView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconView)
        
        iconLeadingConstraint = iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -6)
        iconTrailingConstraint = iconView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 6)
        
        NSLayoutConstraint.activate([
            iconLeadingConstraint,
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 1.2),
            iconView.heightAnchor.constraint(equalTo: iconView.widthAnchor)
        ])
        
        addTarget(self, action: #selector(toggleSwitch), for: .touchUpInside)
    }
    
    @objc private func toggleSwitch() {
        isOn.toggle()
        
        setBackgroundImage(isOn ? onBackground : offBackground, for: .normal)
        
        iconView.image = isOn ? onIcon : offIcon
        
        UIView.animate(withDuration: 0.25) {
            if self.isOn {
                self.iconLeadingConstraint.isActive = false
                self.iconTrailingConstraint.isActive = true
            } else {
                self.iconTrailingConstraint.isActive = false
                self.iconLeadingConstraint.isActive = true
            }
            self.layoutIfNeeded()
        }
    }
}






import UIKit

final class SettingsView: UIView {
    
    //MARK: Views
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Arrowback"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var backGorundView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Background")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var logoView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Logo")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //TextField
    lazy var keyImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Key")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.setContentHuggingPriority(.required, for: .horizontal)
        image.setContentHuggingPriority(.required, for: .vertical)
        
        return image
    }()

    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        textField.backgroundColor = .clear
        textField.textAlignment = .left
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        // Плейсхолдер с нужным цветом
        textField.attributedPlaceholder = NSAttributedString(
            string: "Enter your key",
            attributes: [
                .foregroundColor: UIColor.white.withAlphaComponent(0.6)
            ]
        )
        
        return textField
    }()
    
    lazy var containerForTextField: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [keyImageView, textField])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var fonForTextField: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Backlight")
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //Bittons
    lazy var firstButton:  UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "Slot"), for: .normal)
        button.setTitle("Get the key", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.tintColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var secondButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setBackgroundImage(UIImage(named: "Slot"), for: .normal)
        
        // Текст
        button.setTitle("Kovalenko Bot", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.tintColor = .clear
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    lazy var stacForButtons: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(firstButton)
        stack.addArrangedSubview(secondButton)
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    
    //MARK: Life Cycle
    init() {
        super.init(frame: .zero)
        setView()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView(){
        addSubview(backGorundView)   // фон первым
        addSubview(backButton)       // затем кнопка поверх
        addSubview(logoView)
        addSubview(containerForTextField)
        addSubview(fonForTextField)
        addSubview(stacForButtons)
    }
    func setConstraint(){
        NSLayoutConstraint.activate([
            backGorundView.topAnchor.constraint(equalTo: topAnchor),
            backGorundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backGorundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backGorundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            backButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.04),
            backButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.03),
            
            logoView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            logoView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.634),
            logoView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.344),
            
            stacForButtons.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
            stacForButtons.centerXAnchor.constraint(equalTo: centerXAnchor),
            stacForButtons.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.71),
            stacForButtons.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.13),
            
            containerForTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.927),
            containerForTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerForTextField.bottomAnchor.constraint(equalTo: stacForButtons.topAnchor, constant: -50),
            containerForTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1),
            
            fonForTextField.topAnchor.constraint(equalTo: keyImageView.bottomAnchor),
            fonForTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            fonForTextField.widthAnchor.constraint(equalTo: widthAnchor),
            
            keyImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.034),
            keyImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.034),
            
        ])
        
    }
}


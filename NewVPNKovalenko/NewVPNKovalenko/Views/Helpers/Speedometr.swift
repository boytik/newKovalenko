import UIKit

class SpeedFillView: UIView {
    
    var progress: CGFloat = 0 { didSet { setNeedsLayout() } }
    
    var startAngleDeg: CGFloat = 121 { didSet { setNeedsLayout() } }
    var endAngleDeg: CGFloat = 421 { didSet { setNeedsLayout() } }
    var innerRadiusRatio: CGFloat = 0.76 { didSet { setNeedsLayout() } }
    
    private let backgroundLayer = CAShapeLayer()
    private let fillLayer = CAShapeLayer()
    private let gradientLayer = CAGradientLayer()
    private let ticksLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
        setupLayers()
    }
    
    private func setupLayers() {
        // Серое кольцо
        backgroundLayer.fillColor = UIColor(named: "Speed")?.cgColor
        layer.addSublayer(backgroundLayer)
        
        // Градиент прогресса
        gradientLayer.colors = [
            UIColor.orange.cgColor,
            UIColor.orange.withAlphaComponent(0.7).cgColor,
            UIColor(named: "Speed")?.cgColor ?? UIColor.darkGray.cgColor
        ]
        layer.addSublayer(gradientLayer)
        
        // Маска для прогресса
        fillLayer.fillColor = UIColor.black.cgColor
        gradientLayer.mask = fillLayer
        
        // Слой рисок
        ticksLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(ticksLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        updatePaths()
        drawTicksAndNumbers()
    }
    
    private func updatePaths() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let outerRadius = min(bounds.width, bounds.height) / 2
        let innerRadius = outerRadius * innerRadiusRatio
        
        let startAngle = startAngleDeg * .pi / 180
        let endAngle = endAngleDeg * .pi / 180
        
        // Серый фон
        let bgPath = UIBezierPath()
        bgPath.addArc(withCenter: center, radius: outerRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        bgPath.addArc(withCenter: center, radius: innerRadius, startAngle: endAngle, endAngle: startAngle, clockwise: false)
        bgPath.close()
        backgroundLayer.path = bgPath.cgPath
        
        // Заполненная часть
        let sweepAngle = startAngle + (endAngle - startAngle) * progress
        let fillPath = UIBezierPath()
        fillPath.addArc(withCenter: center, radius: outerRadius, startAngle: startAngle, endAngle: sweepAngle, clockwise: true)
        fillPath.addArc(withCenter: center, radius: innerRadius, startAngle: sweepAngle, endAngle: startAngle, clockwise: false)
        fillPath.close()
        fillLayer.path = fillPath.cgPath
    }
    
    private func drawTicksAndNumbers() {
        ticksLayer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2
        let startAngle = startAngleDeg * .pi / 180
        let endAngle = endAngleDeg * .pi / 180
        let totalAngle = endAngle - startAngle
        
        let tickLengthInner: CGFloat = radius * 0.2
        let fontSize: CGFloat = radius * 0.14
        let baseTextRadius: CGFloat = radius + fontSize * 0.9 // Увеличен радиус для текста, чтобы цифры не прилипали
        
        // 0–30 шаг 5, 40–80 шаг 10
        let values: [CGFloat] = Array(stride(from: 0, through: 30, by: 5)) +
                                Array(stride(from: 40, through: 80, by: 10))
        
        for (index, value) in values.enumerated() {
            let angle = startAngle + (CGFloat(index) / CGFloat(values.count - 1)) * totalAngle
            
            // Риски
            let tickLayer = CAShapeLayer()
            let tickPath = UIBezierPath()
            tickPath.move(to: CGPoint(x: center.x + cos(angle) * (radius - tickLengthInner),
                                      y: center.y + sin(angle) * (radius - tickLengthInner)))
            tickPath.addLine(to: CGPoint(x: center.x + cos(angle) * radius,
                                         y: center.y + sin(angle) * radius))
            tickLayer.path = tickPath.cgPath
            tickLayer.strokeColor = UIColor.orange.cgColor
            tickLayer.lineWidth = max(2, radius * 0.012)
            ticksLayer.addSublayer(tickLayer)
            
            // Цифры
            let textLayer = CATextLayer()
            textLayer.string = "\(Int(value))"
            textLayer.font = "SegoeUI" as CFTypeRef
            textLayer.fontSize = fontSize
            textLayer.foregroundColor = UIColor.white.cgColor
            textLayer.alignmentMode = .center
            textLayer.contentsScale = UIScreen.main.scale
            
            // Позиционирование текста
            let textRadius = baseTextRadius
            let textX = center.x + cos(angle) * textRadius
            let textY = center.y + sin(angle) * textRadius
            textLayer.frame = CGRect(
                x: textX - fontSize,
                y: textY - fontSize / 2,
                width: fontSize * 2,
                height: fontSize * 1.4
            )
            ticksLayer.addSublayer(textLayer)
        }
    }
}




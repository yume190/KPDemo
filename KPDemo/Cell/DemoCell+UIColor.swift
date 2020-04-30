//
//  PresentBasicTableViewCell.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/16.
//  Copyright © 2019 Yume. All rights reserved.
//

import UIKit

public final class DemoUIColorCell: DemoBasicCell {
    // MARK: UI
    private final lazy var uiRed = UIStackView.customWithSlider()
    private final lazy var uiGreen = UIStackView.customWithSlider()
    private final lazy var uiBlue = UIStackView.customWithSlider()
    private final lazy var uiAlpha = UIStackView.customWithSlider()
    
    // MARK: Values
    private final var _red: CGFloat = 1
    private final var _green: CGFloat = 1
    private final var _blue: CGFloat = 1
    private final var _alpha: CGFloat = 1
    private final var _color: UIColor {
        return UIColor(red: _red/255.0, green: _green/255.0, blue: _blue/255.0, alpha: _alpha/100.0)
    }
    
    final override public func setup() {
        super.setup()
        self.basicValueLabel.isHidden = true
        
        stack.arrange(views: [
            uiRed.stack,
            uiGreen.stack,
            uiBlue.stack,
            uiAlpha.stack,
        ])
        
        self.uiRed.slider.addTarget(self, action: #selector(self.reding(sender:)), for: .valueChanged)
        self.uiGreen.slider.addTarget(self, action: #selector(self.greening(sender:)), for: .valueChanged)
        self.uiBlue.slider.addTarget(self, action: #selector(self.blueing(sender:)), for: .valueChanged)
        self.uiAlpha.slider.addTarget(self, action: #selector(self.alphaing(sender:)), for: .valueChanged)
        
        uiAlpha.slider.maximumValue = 100
        
        self.uiRed.label.widthAnchor.constraint(equalToConstant: 60).isActive = true
        self.uiGreen.label.widthAnchor.constraint(equalToConstant: 60).isActive = true
        self.uiBlue.label.widthAnchor.constraint(equalToConstant: 60).isActive = true
        self.uiAlpha.label.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    final override func getValue() {
        super.getValue()
        
        if let value: UIColor = self.getter?() as? UIColor {
            self.getting(ui: value)
            return
        }
        
        if let value: Any = self.getter?(), type(of: value) == CGColor.self {
            let cg = value as! CGColor
            self.getting(ui: UIColor(cgColor: cg))
        }
    }
    
    private final func getting(ui: UIColor) {
        ui.getRed(&_red, green: &_green, blue: &_blue, alpha: &_alpha)
        
        _red = CGFloat(_red*255.0)
        _green = CGFloat(_green*255.0)
        _blue = CGFloat(_blue*255.0)
        _alpha = CGFloat(_alpha*100.0)
        
        self.uiRed.label.text = "\(_red)"
        self.uiGreen.label.text = "\(_green)"
        self.uiBlue.label.text = "\(_blue)"
        self.uiAlpha.label.text = "\(_alpha)"
        
        self.uiRed.slider.value = Float(_red)
        self.uiGreen.slider.value = Float(_green)
        self.uiBlue.slider.value = Float(_blue)
        self.uiAlpha.slider.value = Float(_alpha)
    }
}

// MARK: Actions
extension DemoUIColorCell {
    @objc
    private final func reding(sender: UISlider) {
        self._red = CGFloat(sender.value)
        self.setValue()
    }
    
    @objc
    private final func greening(sender: UISlider) {
        self._green = CGFloat(sender.value)
        self.setValue()
    }
    
    @objc
    private final func blueing(sender: UISlider) {
        self._blue = CGFloat(sender.value)
        self.setValue()
    }
    
    @objc
    private final func alphaing(sender: UISlider) {
        self._alpha = CGFloat(sender.value)
        self.setValue()
    }
    
    private final func setValue() {
        self.setter?(self._color)
        self.setter?(self._color.cgColor)
        self.getValue()
    }
}

extension DemoUIColorCell: DemoCellRegistable {
    public static var registTypes: [Any.Type] {
        return [
            andOptional(_type: UIColor.self),
            andOptional(_type: CGColor.self),
        ].flatMap{$0}
    }
}

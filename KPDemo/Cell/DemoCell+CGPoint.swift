//
//  PresentBasicTableViewCell.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/16.
//  Copyright © 2019 Yume. All rights reserved.
//

import UIKit

public final class DemoCGPointCell: DemoBasicCell {
    // MARK: UI
    private final lazy var x = UIStackView.customWithSlider()
    private final lazy var y = UIStackView.customWithSlider()
    
    // MARK: Values
    private final var _point: CGPoint = .zero
    
    final override public func setup() {
        super.setup()
        self.basicValueLabel.isHidden = true
        
        stack.arrange(views: [
            self.x.stack,
            self.y.stack,
            ])
        
        self.x.slider.addTarget(self, action: #selector(self.xing(sender:)), for: .valueChanged)
        self.y.slider.addTarget(self, action: #selector(self.ying(sender:)), for: .valueChanged)
    }
    
    override final func setupDefault(showable: DemoShowable) {
        super.setupDefault(showable: showable)
        if case .limit(let limit) = showable.info {
            x.slider.maximumValue = Float(limit.max)
            y.slider.maximumValue = Float(limit.max)
            x.slider.minimumValue = Float(limit.min)
            y.slider.minimumValue = Float(limit.min)
        }
    }
    
    final override func getValue() {
        super.getValue()
        
        guard let value: CGPoint = self.getter?() as? CGPoint else {return}
        self._point = value
        
        self.x.label.text = String(format: "x: %.2f", self._point.x)
        self.y.label.text = String(format: "y: %.2f", self._point.y)
        
        self.x.slider.value = Float(self._point.x)
        self.y.slider.value = Float(self._point.y)
    }
}

// MARK: Actions
extension DemoCGPointCell {
    @objc
    private final func xing(sender: UISlider) {
        self._point.x = CGFloat(sender.value)
        self.setter?(self._point)
        self.getValue()
    }
    
    @objc
    private final func ying(sender: UISlider) {
        self._point.y = CGFloat(sender.value)
        self.setter?(self._point)
        self.getValue()
    }
}

extension DemoCGPointCell: DemoCellRegistable {
    public static var registTypes: [Any.Type] {
        return andOptional(_type: CGPoint.self)
    }
}

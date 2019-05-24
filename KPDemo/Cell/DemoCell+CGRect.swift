//
//  PresentBasicTableViewCell.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/16.
//  Copyright © 2019 Yume. All rights reserved.
//

import UIKit

public final class DemoCGRectCell: DemoBasicCell {
    // MARK: UI
    private final lazy var x = UIStackView.customWithSlider()
    private final lazy var y = UIStackView.customWithSlider()
    private final lazy var width = UIStackView.customWithSlider()
    private final lazy var height = UIStackView.customWithSlider()
    
    // MARK: Values
    private final var _rect: CGRect = .zero
    
    final override public func setup() {
        super.setup()
        self.basicValueLabel.isHidden = true
        
        stack.arrange(views: [
            self.x.stack,
            self.y.stack,
            self.width.stack,
            self.height.stack,
            ])
        self.x.slider.addTarget(self, action: #selector(self.xing(sender:)), for: .valueChanged)
        self.y.slider.addTarget(self, action: #selector(self.ying(sender:)), for: .valueChanged)
        self.width.slider.addTarget(self, action: #selector(self.widthing(sender:)), for: .valueChanged)
        self.height.slider.addTarget(self, action: #selector(self.heighting(sender:)), for: .valueChanged)
    }
    
    override final func setupDefault(showable: DemoShowable) {
        super.setupDefault(showable: showable)
        if case .limit(let limit) = showable.info {
            x.slider.maximumValue = Float(limit.max)
            y.slider.maximumValue = Float(limit.max)
            x.slider.minimumValue = Float(limit.min)
            y.slider.minimumValue = Float(limit.min)
            
            width.slider.maximumValue = Float(limit.max)
            height.slider.maximumValue = Float(limit.max)
            width.slider.minimumValue = Float(limit.min)
            height.slider.minimumValue = Float(limit.min)
        }
    }

    final override func getValue() {
        super.getValue()
        
        if let value = self.getter?() as? CGRect {
            self._rect = value
            
            self.x.label.text = String(format: "x: %.2f", self._rect.origin.x)
            self.y.label.text = String(format: "y: %.2f", self._rect.origin.y)
            self.width.label.text = String(format: "width: %.2f", self._rect.size.width)
            self.height.label.text = String(format: "height: %.2f", self._rect.size.height)
            
            self.x.slider.value = Float(self._rect.origin.x)
            self.y.slider.value = Float(self._rect.origin.y)
            self.width.slider.value = Float(self._rect.size.width)
            self.height.slider.value = Float(self._rect.size.height)
        }
    }
}

// MARK: Actions
extension DemoCGRectCell {
    @objc
    private final func xing(sender: UISlider) {
        self._rect.origin.x = CGFloat(sender.value)
        self.setter?(self._rect)
        self.getValue()
    }
    
    @objc
    private final func ying(sender: UISlider) {
        self._rect.origin.y = CGFloat(sender.value)
        self.setter?(self._rect)
        self.getValue()
    }
    
    @objc
    private final func widthing(sender: UISlider) {
        self._rect.size.width = CGFloat(sender.value)
        self.setter?(self._rect)
        self.getValue()
    }
    
    @objc
    private final func heighting(sender: UISlider) {
        self._rect.size.height = CGFloat(sender.value)
        self.setter?(self._rect)
        self.getValue()
    }
}

extension DemoCGRectCell: DemoCellRegistable {
    public static var registTypes: [Any.Type] {
        return andOptional(_type: CGRect.self)
    }
}

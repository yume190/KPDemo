//
//  PresentBasicTableViewCell.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/16.
//  Copyright © 2019 Yume. All rights reserved.
//

import UIKit

public final class DemoCGSizeCell: DemoBasicCell {
    // MARK: UI
    private final lazy var width = UIStackView.customWithSlider()
    private final lazy var height = UIStackView.customWithSlider()
    
    // MARK: Values
    private final var _size: CGSize = .zero
    
    override
    public final func setup() {
        super.setup()
        self.basicValueLabel.isHidden = true
        
        stack.arrange(views: [
            self.width.stack,
            self.height.stack,
            ])
        
        self.width.slider.addTarget(self, action: #selector(self.widthing(sender:)), for: .valueChanged)
        self.height.slider.addTarget(self, action: #selector(self.heighting(sender:)), for: .valueChanged)
    }
    
    override final func setupDefault(showable: DemoShowable) {
        super.setupDefault(showable: showable)
        if case .limit(let limit) = showable.info {
            width.slider.maximumValue = Float(limit.max)
            height.slider.maximumValue = Float(limit.max)
            width.slider.minimumValue = Float(limit.min)
            height.slider.minimumValue = Float(limit.min)
        }
    }
    
    override
    internal final func getValue() {
        super.getValue()
        
        if let value = self.getter?() as? CGSize {
            self._size = value
            
            self.width.label.text = String(format: "width: %.2f", self._size.width)
            self.height.label.text = String(format: "height: %.2f", self._size.height)
            
            self.width.slider.value = Float(self._size.width)
            self.height.slider.value = Float(self._size.height)
        }
    }
}

// MARK: Actions
extension DemoCGSizeCell {
    @objc
    private final func widthing(sender: UISlider) {
        self._size.width = CGFloat(sender.value)
        self.setter?(self._size)
        self.getValue()
    }
    
    @objc
    private final func heighting(sender: UISlider) {
        self._size.height = CGFloat(sender.value)
        self.setter?(self._size)
        self.getValue()
    }
}

extension DemoCGSizeCell: DemoCellRegistable {
    public static var registTypes: [Any.Type] {
        return andOptional(_type: CGSize.self)
    }
}

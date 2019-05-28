//
//  PresentBasicTableViewCell.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/16.
//  Copyright © 2019 Yume. All rights reserved.
//

import UIKit

public final class DemoPrimtiveCell: DemoBasicCell {
    // MARK: UI
    private final lazy var value = UIStackView.customWithSlider()
    
    // MARK: Values
    private final var _value: NSNumber = NSNumber(value: 0)
    
    final override public func setup() {
        super.setup()
        self.basicValueLabel.isHidden = true
        
        stack.arrange(views: [
            self.value.stack,
            ])
        self.value.slider.addTarget(self, action: #selector(self.valueing(sender:)), for: .valueChanged)
    }
    
    override final func setupDefault(showable: DemoShowable) {
        super.setupDefault(showable: showable)
//        self.value.slider.isHidden = !showable.isWritable
        
        if case .limit(let limit) = showable.info {
            value.slider.maximumValue = Float(limit.max)
            value.slider.minimumValue = Float(limit.min)
        }
    }
    
    final override func getValue() {
        super.getValue()
        
        if let value = self.getter?() as? NSNumber {
            self._value = value
            
            self.value.label.text =
                String(format: "value: %.2f", self._value.floatValue)

            self.value.slider.value = self._value.floatValue
        }
    }
}

// MARK: Actions
extension DemoPrimtiveCell {
    @objc
    private func valueing(sender: UISlider) {
        self._value = NSNumber(value: sender.value)
        self.setter?(self._value)
        self.getValue()
    }
}

extension DemoPrimtiveCell: DemoCellRegistable {
    public static var registTypes: [Any.Type] {
        return [
            andOptional(_type: Int.self),
            andOptional(_type: Int8.self),
            andOptional(_type: Int16.self),
            andOptional(_type: Int32.self),
            andOptional(_type: Int64.self),
            
            andOptional(_type: Float.self),
            andOptional(_type: Float32.self),
            andOptional(_type: Float64.self),
            andOptional(_type: Double.self),
            andOptional(_type: CGFloat.self),
        ].flatMap {$0}
    }
}

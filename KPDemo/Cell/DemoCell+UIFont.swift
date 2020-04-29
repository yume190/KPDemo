//
//  DemoCell+UIFont.swift
//  KPDemo
//
//  Created by Yume on 2020/4/29.
//  Copyright © 2020 Yume. All rights reserved.
//

import Foundation

public final class DemoUIFontCell: DemoBasicCell {
    private final lazy var size = UIStackView.customWithSlider()
    
    // MARK: Values
    private final var _size: CGFloat = 0
    private final var _font: UIFont {
        return .systemFont(ofSize: _size)
    }
    
    final override public func setup() {
        super.setup()
        self.basicValueLabel.isHidden = true
        
        stack.arrange(views: [
            self.size.stack
        ])
        self.size.slider.addTarget(self, action: #selector(self.valueing(sender:)), for: .valueChanged)
    }
    
    override final func setupDefault(showable: DemoShowable) {
        super.setupDefault(showable: showable)
        //        self.value.slider.isHidden = !showable.isWritable
        
        size.slider.maximumValue = 100
        size.slider.minimumValue = 0
    }
    
    final override func getValue() {
        super.getValue()
        
        if let font = self.getter?() as? UIFont {
            self._size = font.pointSize
            self.size.label.text =
                .init(format: "size: %.2f", self._size)
            self.size.slider.value = Float(self._size)
        }
    }
}

// MARK: Actions
extension DemoUIFontCell {
    @objc
    private func valueing(sender: UISlider) {
        self._size = CGFloat(sender.value)
        self.setter?(self._font)
        self.getValue()
    }
}

extension DemoUIFontCell: DemoCellRegistable {
    public static var registTypes: [Any.Type] {
        return [
            andOptional(_type: UIFont.self),
            ].flatMap {$0}
    }
}

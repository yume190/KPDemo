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
    private final lazy var widthValue: UISlider = UISlider.custom { (slider) in
        slider.addTarget(self, action: #selector(self.widthing(sender:)), for: .valueChanged)
    }
    private final lazy var widthValueLabel: UILabel = UILabel.custom { (label) in
        label.font = UIFont.systemFont(ofSize: 15)
    }
    private final lazy var widthStack: UIStackView = UIStackView.custom { (stack) in
        stack.arrange(views: [
            self.widthValueLabel,
            self.widthValue,
            ])
    }
    
    private final lazy var heightValue: UISlider = UISlider.custom { (slider) in
        slider.addTarget(self, action: #selector(self.heighting(sender:)), for: .valueChanged)
    }
    private final lazy var heightValueLabel: UILabel = UILabel.custom { (label) in
        label.font = UIFont.systemFont(ofSize: 15)
    }
    private final lazy var heightStack: UIStackView = UIStackView.custom { (stack) in
        stack.arrange(views: [
            self.heightValueLabel,
            self.heightValue,
            ])
    }
    
    // MARK: Values
    private final var _size: CGSize = .zero
    
    override
    public final func setup() {
        super.setup()
        self.basicValueLabel.isHidden = true
        
        stack.arrange(views: [
            self.widthStack,
            self.heightStack,
            ])
    }
    
//    public override func show<T>(showable: DemoShowable, item: Demo<T>) {
//        super.show(showable: showable, item: item)
//    }
    
    override final func setupDefault(showable: DemoShowable) {
        super.setupDefault(showable: showable)
        if case .limit(let limit) = showable.info {
            widthValue.maximumValue = Float(limit.max)
            heightValue.maximumValue = Float(limit.max)
            widthValue.minimumValue = Float(limit.min)
            heightValue.minimumValue = Float(limit.min)
        }
    }
    
    override
    internal final func getValue() {
        super.getValue()
        
        if let value = self.getter?() as? CGSize {
            self._size = value
            
            self.widthValueLabel.text = String(format: "width: %.2f", self._size.width)
            self.heightValueLabel.text = String(format: "height: %.2f", self._size.height)
            
            self.widthValue.value = Float(self._size.width)
            self.heightValue.value = Float(self._size.height)
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

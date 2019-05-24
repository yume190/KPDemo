//
//  PresentBasicTableViewCell.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/16.
//  Copyright © 2019 Yume. All rights reserved.
//

import UIKit

public class DemoBoolCell: DemoBasicCell {
    private final lazy var value = UIStackView.customWithSwitch()
    
    override
    final public func setup() {
        super.setup()
        self.basicValueLabel.isHidden = true

        self.stack.addArrangedSubview(value.stack)
        
        self.value.switch.addTarget(
            self,
            action: #selector(self.switching(sender:)),
            for: .valueChanged
        )
    }
    
    internal final override func getValue() {
        super.getValue()
        if let value = self.getter?() as? Bool {
            self.value.label.text = "\(value)"
            self.value.switch.isOn = value
        }
    }
}

extension DemoBoolCell {
    @objc
    private final func switching(sender: UISwitch) {
        self.setter?(sender.isOn)
        self.getValue()
    }
}

extension DemoBoolCell: DemoCellRegistable {
    public static var registTypes: [Any.Type] {
        return andOptional(_type: Bool.self)
    }
}


//
//  PresentBasicTableViewCell.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/16.
//  Copyright © 2019 Yume. All rights reserved.
//

import UIKit

public class DemoBoolCell: DemoBasicCell {
    private final lazy var boolSwitch: UISwitch = UISwitch()
    private final lazy var boolValueLabel: UILabel = UILabel.custom()
    
    override
    final public func setup() {
        super.setup()
        self.basicValueLabel.isHidden = true
        let _stack: UIStackView = UIStackView.custom { (stack: UIStackView) in
            stack.arrange(views: [
                self.boolValueLabel,
                self.boolSwitch,
                ])
        }

        self.stack.addArrangedSubview(_stack)
        
        self.boolSwitch.addTarget(
            self,
            action: #selector(self.switching(sender:)),
            for: .valueChanged
        )
    }
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    internal final override func getValue() {
        super.getValue()
        if let value = self.getter?() as? Bool {
            self.boolValueLabel.text = "\(value)"
            self.boolSwitch.isOn = value
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


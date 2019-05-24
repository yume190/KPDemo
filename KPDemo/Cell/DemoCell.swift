//
//  PresentBasicTableViewCell.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/16.
//  Copyright © 2019 Yume. All rights reserved.
//

import UIKit

open class DemoBasicCell: UITableViewCell, DemoCellShowable {
    private final lazy var nameLabel: UILabel = UILabel.custom()
    private final lazy var isNilSwitch: UISwitch = UISwitch()
    private final lazy var _stack: UIStackView = UIStackView.custom { (stack: UIStackView) in
        stack.arrange(views: [
            self.nameLabel,
            self.isNilSwitch
        ])
    }
    
    private final lazy var demoDescriptionLabel: UILabel = UILabel.custom { (label) in
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
    }
    
    private final lazy var typeLabel: UILabel = UILabel.custom { (label) in
        label.font = UIFont.systemFont(ofSize: 15)
    }
    
    public final lazy var basicValueLabel: UILabel = UILabel.custom { (label) in
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
    }
    
    public final lazy var stack: UIStackView = UIStackView.custom { (stack) in
        stack.axis = .vertical
        
        self.contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.topAnchor.constraint(equalTo: stack.topAnchor, constant: -8).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: stack.bottomAnchor, constant: 8).isActive = true
        self.contentView.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: -20).isActive = true
        self.contentView.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 20).isActive = true
        
        stack.arrange(views: [
            self._stack,
            self.typeLabel,
            self.demoDescriptionLabel,
            self.basicValueLabel,
            ])
    }
    
    public var getter: (() -> Any?)?
    public var setter: ((Any?) -> Void)?
    
    deinit {
        self.getter = nil
        self.setter = nil
    }

    open func setup() {
        _ = self.stack
        self.isNilSwitch.addTarget(
            self,
            action: #selector(self.switchNil(sender:)),
            for: .valueChanged
        )
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    open func show<T>(showable: DemoShowable, item: Demo<T>) {
        self.setupGetterAndSetter(showable: showable, item: item)
        self.setupDefault(showable: showable)
        self.getValue()
    }
    
    private final func setupGetterAndSetter<T>(showable: DemoShowable, item: Demo<T>) {
        weak var _showable = showable
        self.getter = {
            return _showable?[item]
        }
        self.setter = { [weak self] any in
            _showable?[item] = any
            if _showable?.isReloadWhenSet ?? false {
                self?.tableView?.reloadData()
            }
        }
    }
    
    internal func setupDefault(showable: DemoShowable) {
        self.nameLabel.text = showable.name
        
        self.typeLabel.isHidden = DemoConfig.default.isShowType
        self.typeLabel.text = showable.valueTypeName
        
        self.demoDescriptionLabel.text = showable.demoDescription
        self.demoDescriptionLabel.isHidden = showable.demoDescription == nil
        
        guard let value = self.getter?() else {return}
        let isOptional = Mirror(reflecting: value)
            .displayStyle == .optional
        self.isNilSwitch.isHidden = !showable.isWritable || !isOptional
    }
    
    internal func getValue() {
        guard let value = self.getter?() else {return}
        self.basicValueLabel.text = "\(value)"
    }
}

// MARK: Action
extension DemoBasicCell {
    @objc
    private final func switchNil(sender: UISwitch) {
        if sender.isOn {
            self.setter?(nil)
        }
        self.getValue()
    }
}

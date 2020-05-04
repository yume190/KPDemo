//
//  SeperatorDemoItem.swift
//  KPDemo
//
//  Created by Yume on 2020/4/30.
//  Copyright © 2020 Yume. All rights reserved.
//

import Foundation

public final class SeperatorDemoItem: DemoShowable {
    public let demoDescription: String? = nil
    public let cell: (UITableViewCell & DemoCellShowable).Type = DemoSeperatorCell.self
    public let info: DemoInfomation = .nothing
    public let isReloadWhenSet: Bool = false
    public let name: String? = nil
    public let targetTypeName: String = ""
    public let valueTypeName: String = ""
    public let isWritable: Bool = false
    
    internal let background: UIColor
    internal let height: CGFloat
    public init(_ background: UIColor = .black, _ height: CGFloat = 3) {
        self.background = background
        self.height = height
    }
    
    public subscript<T>(item: Demo<T>) -> Any? {
        get { return nil }
        set {}
    }
}

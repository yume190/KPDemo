//
//  DemoBuilder.swift
//  KPDemo
//
//  Created by Yume on 2020/4/30.
//  Copyright © 2020 Yume. All rights reserved.
//

import Foundation

@_functionBuilder
public struct DemoBuilder {
    // MARK: Block
    public static func buildBlock(_ items: DemoShowable...) -> [DemoShowable] {
        return items
    }
    
    // MARK: Expression
    public static func buildExpression(_ expression: String) -> TitleDemoItem {
        return .init(expression)
    }
    
    public static func buildExpression(_ expression: TitleDemoItem) -> TitleDemoItem {
        return expression
    }
    
    public static func buildExpression<Target, Value>(_ expression: KeyPath<Target, Value>) -> DemoItem<Target, Value> {
        return DemoItem(keyPath: expression)
    }
    
    public static func buildExpression<Target, Value>(_ expression: (keyPath :KeyPath<Target, Value>, description: String)) -> DemoItem<Target, Value> {
        return DemoItem(keyPath: expression.keyPath, demoDescription: expression.description)
    }
    
    public static func buildExpression<Target, Value>(_ expression: DemoItem<Target, Value>) -> DemoItem<Target, Value> {
        return expression
    }
    
    public static func buildExpression(_ expression: DemoShowable) -> DemoShowable {
        return expression
    }
}

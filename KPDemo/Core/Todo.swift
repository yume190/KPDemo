//
//  Todo.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/20.
//  Copyright © 2019 Yume. All rights reserved.
//

import Foundation

// x
//["a"] [A.a]
//struct A {
//    static var a: Int = 1
//    static var b: Int = 1
//}
// x
//enum A {
//    case a
//    case b
//}

// o
//enum A: CaseIterable {
//    case a
//    case b
//}

// o
//enum A: OptionSet {
//    static var a: Int = 1
//    static var b: Int = 2
//}


//extension OptionSet where RawValue: FixedWidthInteger {
//    public static var allItem: [Self] {
//        let size = RawValue.min == 0 ? RawValue.bitWidth : RawValue.bitWidth - 1
//        let range = 0..<size
//
//        let numbers = [0] + range.map { (offSet: Int) -> RawValue in
//            let mask = RawValue(1 << offSet)
//            return RawValue.max & mask
//        }
//
//        return numbers.compactMap { Self(rawValue: $0) }
//    }
//
//    public static var all: Self {
//        return self.allItem.reduce(Self()) { (o, next) -> Self in
//            return o.union(next)
//        }
//    }
//}

//
//  UIView+Rx.swift
//  ReactiveARKit_Example
//
//  Created by jalil.kennedy on 11/14/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UIView {
    /// Bindable sink for 'backgroundColor' property
    public var backgroundColor: Binder<UIColor> {
        return Binder(self.base) { view, color in
            view.backgroundColor = color
        }
    }
}

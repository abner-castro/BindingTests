//
//  Observable.swift
//  BindingTests
//
//  Created by Abner Castro on 20/04/23.
//

import Foundation

struct Observable<T>: Bindable {
    typealias Binder = T
    
    var value: Binder? {
        get { _value }
        set {
            _value = newValue
            listener?(newValue)
        }
    }
    var listener: ((Binder?) -> Void)?
    
    private var _value: Binder?
    
    init(_ value: Binder? = nil) {
        self.value = value
    }
    
    mutating func changeBind(_ value: Binder?) {
        self._value = value
    }
    
    mutating func onNext(_ value: Binder?) {
        self.value = value
    }
    
    mutating func bind(_ listener: @escaping (Binder?) -> Void) {
        self.listener = listener
    }
}

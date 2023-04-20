//
//  ObservableTests.swift
//  BindingTestsTests
//
//  Created by Abner Castro on 20/04/23.
//

import XCTest
@testable import BindingTests

final class ObservableTests: XCTestCase {
    
    private var sutString: Observable<String>!
    private var sutInt: Observable<Int>!
    private var sutCustomClass: Observable<CustomTestClass>!
    private var sut: Observable<Bool>!
    private var listenerCalled: Bool!
    
    override func setUp() {
        super.setUp()
        sutString = Observable<String>()
        sutInt = Observable<Int>(nil)
        sutCustomClass = Observable<CustomTestClass>(nil)
        sut = Observable<Bool>(false)
        listenerCalled = false
    }
    
    func test_initializeWithAnyType_objectIsNil() {
        XCTAssertNotNil(sutString)
        XCTAssertNotNil(sutInt)
        XCTAssertNotNil(sutCustomClass)
    }
    
    func test_initializeWithAnyType_objectIsNotNil() {
        sutString = Observable<String>(String())
        sutInt = Observable<Int>(0)
        sutCustomClass = Observable<CustomTestClass>(CustomTestClass())
        XCTAssertNotNil(sutString.value)
        XCTAssertNotNil(sutInt.value)
        XCTAssertNotNil(sutCustomClass.value)
    }
    
    func test_valueChange_throughSetter() {
        sutString = Observable<String>("Hola")
        sutString.value = "Bye"
        XCTAssertEqual(sutString.value, "Bye")
    }
    
    func test_valueChange_throughSetter_callListener() {
        sut.listener = { [weak self] value in
            guard let value = value else { return }
            self?.listenerCalled = value
        }
        sut.value = true
        XCTAssertTrue(listenerCalled)
    }
    
    func test_valueChanged_throughFunction_listenerIsCalled() {
        sut.listener = { [weak self] value in
            guard let value = value else { return }
            self?.listenerCalled = value
        }
        sut.onNext(true)
        XCTAssertTrue(listenerCalled)
        XCTAssertTrue(sut.value!)
    }
    
    func test_valueChanged_throughFunction_listenerIsNotCalled() {
        sut.listener = { [weak self] value in
            guard let value = value else { return }
            self?.listenerCalled = value
        }
        sut.changeBind(true)
        XCTAssertFalse(listenerCalled)
        XCTAssertTrue(sut.value!)
    }
    
    func test_listenerChanged_throughFunction() {
        sut.bind { [weak self] value in
            guard let value = value else { return }
            self?.listenerCalled = value
        }
        sut.onNext(true)
        XCTAssertTrue(listenerCalled)
    }
    
    override func tearDown() {
        sutString = Observable<String>()
        sutInt = Observable<Int>(nil)
        sutCustomClass = Observable<CustomTestClass>(nil)
        sut = Observable<Bool>(false)
        listenerCalled = false
    }
    
    // MARK: - Helper Methods
    private class CustomTestClass {}
    
}

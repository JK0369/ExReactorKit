//
//  ExCounterTests.swift
//  ExCounterTests
//
//  Created by 김종권 on 2021/11/30.
//

import XCTest
@testable import ExCounter

class ExCounterTests: XCTestCase {
    
    var sut = UIStoryboard(name: "Counter", bundle: nil)
    
    func testAction_whenDidTapDecreaseButtonInView_thenMutationIsDecreaseInReactor() {
        // Given
        let counterReactor = CounterViewReactor()
        counterReactor.isStubEnabled = true
        
        let counterViewController = sut.instantiateViewController(withIdentifier: "Counter") as! CounterViewController
        counterViewController.loadViewIfNeeded() // IBOutlet과 Action을 구성하기 위해서 호출
        counterViewController.reactor = counterReactor
        
        // When
        counterViewController.decreaseButton.sendActions(for: .touchUpInside)
        
        // Then
        XCTAssertEqual(counterReactor.stub.actions.last, .decrease)
    }

    func testState_whenChangeLoadingStateToTrueInReactor_thenActivityIndicatorViewIsAnimatingInView() {
        // Given
        let counterReactor = CounterViewReactor()
        counterReactor.isStubEnabled = true
        
        let counterViewController = sut.instantiateViewController(withIdentifier: "Counter") as! CounterViewController
        counterViewController.loadViewIfNeeded()
        counterViewController.reactor = counterReactor
        
        // When
        counterReactor.stub.state.value = CounterViewReactor.State(value: 0, isLoading: true)
        
        // Then
        XCTAssertEqual(counterViewController.activityIndicatorView.isAnimating, true)
    }
    
    func testReactor_whenExcuteIncreaseButtonTapActionInView_thenStateIsLoadingInReactor() {
        // Given
        let reactor = CounterViewReactor()
        
        // When
        reactor.action.onNext(.increase)
        
        // Then
        XCTAssertEqual(reactor.currentState.isLoading, true)
    }
}


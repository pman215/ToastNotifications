//
//  SequenceViewAnimatorTests.swift
//  ToastNotifications
//
//  Created by pman215 on 10/30/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

@testable import ToastNotifications
import XCTest

class FakeViewAnimationTask: ViewAnimationTask {

    override func animate() {
        cancel()
        queue?.dequeue(task: self)
    }
}

class SequenceViewAnimatorTests: XCTestCase {

    var showAnimation: ViewAnimationTask!
    var hideAnimation: ViewAnimationTask!
    var sequenceAnimator: SequenceViewAnimator!

    override func setUp() {
        super.setUp()
        showAnimation = FakeViewAnimationTask()
        hideAnimation = FakeViewAnimationTask()
        sequenceAnimator = SequenceViewAnimator(transition: .manual,
                                                showAnimations: [showAnimation],
                                                hideAnimations: [hideAnimation])
    }

    override func tearDown() {
        sequenceAnimator = nil
        super.tearDown()
    }

    func testAnimatableViewCanShow() {
        sequenceAnimator.show()
        XCTAssertEqual(showAnimation.state, .finished)
    }

    func testAnimatableViewCanTransitionAutomatically() {
        sequenceAnimator = SequenceViewAnimator(transition: .automatic,
                                                showAnimations: [showAnimation],
                                                hideAnimations: [hideAnimation])
        sequenceAnimator.show()
        XCTAssertEqual(showAnimation.state, .finished)
        XCTAssertEqual(hideAnimation.state, .finished)
    }

    func testAnimatableViewCanHideBeforeShowing() {
        sequenceAnimator.hide()
        XCTAssertEqual(showAnimation.state, .finished)
        XCTAssertEqual(hideAnimation.state, .finished)
    }

    func testAnimatableViewCanHideWhileShowing() {
        sequenceAnimator.show()
        sequenceAnimator.hide()
        XCTAssertEqual(showAnimation.state, .finished)
        XCTAssertEqual(hideAnimation.state, .finished)
    }
}

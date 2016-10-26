//
//  ToastAnimation.swift
//  ToastNotifications
//
//  Created by pman215 on 6/6/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import UIKit


enum ToastAnimationStyle {
    case autoDismiss
    case manualDismiss
}

struct ToastAnimation {
    let style: ToastAnimationStyle
    let showAnimations: [ViewAnimation]
    let hideAnimations: [ViewAnimation]
}

extension ToastAnimation {

    static func defaultAnimations() -> ToastAnimation {
        let style = ToastAnimationStyle.autoDismiss
        let showAnimations: [ViewAnimation] = {

            func hide(_ view: UIView) {
                view.alpha = 0
            }

            func show(view: UIView) {
                view.alpha = 1
            }

            let intro = ViewAnimation()
                            .delay(0)
                            .duration(1)
                            .initialState(hide)
                            .finalState(show)

            return [intro]
        }()

        let hideAnimations: [ViewAnimation] = {

            func hide(view: UIView) {
                view.alpha = 0
            }

            let exit = ViewAnimation()
                            .delay(1)
                            .duration(1)
                            .finalState(hide)

            return [exit]
        }()

        return ToastAnimation(style: style,
                              showAnimations: showAnimations,
                              hideAnimations: hideAnimations)
    }
}
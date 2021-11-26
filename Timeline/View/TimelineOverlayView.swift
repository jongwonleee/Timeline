//
//  TimelineOverlayView.swift
//  Timeline
//
//  Created by user on 2021/11/26.
//

import UIKit
import SwiftUI

protocol TimelineOverlayViewDelegate {
    func timelineOverlayView(_ :UIView, didTapAddButton: UIButton)
    func timelineOverlayView(_ :UIView, didTapSettingButton: UIButton)
}

class TimelineOverlayView: UIView {
    struct Layout {
        static let buttonSize = CGFloat(50)
        static let buttonPadding = CGFloat(5)
    }

    let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        return button
    }()

    let settingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        return button
    }()

    public var delegate: TimelineOverlayViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configureConstraints()
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        settingButton.addTarget(self, action: #selector(didTapSettingButton), for: .touchUpInside)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        assertionFailure("not allowed access")
    }

    private func addSubviews() {
        addSubview(addButton)
        addSubview(settingButton)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalToConstant: Layout.buttonSize),
            addButton.heightAnchor.constraint(equalToConstant: Layout.buttonSize),
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Layout.buttonPadding),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.buttonPadding),

            settingButton.widthAnchor.constraint(equalToConstant: Layout.buttonSize),
            settingButton.heightAnchor.constraint(equalToConstant: Layout.buttonSize),
            settingButton.topAnchor.constraint(equalTo: topAnchor, constant: Layout.buttonPadding),
            settingButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.buttonPadding),
        ])
    }

    @objc private func didTapAddButton() {
        delegate?.timelineOverlayView(self, didTapAddButton: addButton)
    }

    @objc private func didTapSettingButton() {
        delegate?.timelineOverlayView(self, didTapAddButton: settingButton)
    }
}

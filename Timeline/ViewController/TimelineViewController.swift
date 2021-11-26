//
//  ViewController.swift
//  Timeline
//
//  Created by user on 2021/11/26.
//

import UIKit

class TimelineViewController: UIViewController {
    struct Layout {
        static let lineWidth = CGFloat(5)
    }

    let lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()

    let timelineOverlayView: TimelineOverlayView = {
        let view = TimelineOverlayView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        addSubviews()
        configureConstraints()

        timelineOverlayView.delegate = self

    }

    private func addSubviews() {
        view.addSubview(lineView)
        view.addSubview(timelineOverlayView)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            lineView.widthAnchor.constraint(equalToConstant: Layout.lineWidth),
            lineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lineView.topAnchor.constraint(equalTo: view.topAnchor),
            lineView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            timelineOverlayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            timelineOverlayView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            timelineOverlayView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            timelineOverlayView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }

}

extension TimelineViewController: TimelineOverlayViewDelegate {
    func timelineOverlayView(_ :UIView, didTapAddButton: UIButton) {

    }
    func timelineOverlayView(_ :UIView, didTapSettingButton: UIButton) {
        
    }
}


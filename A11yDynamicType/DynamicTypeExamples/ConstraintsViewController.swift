//
//  ConstraintsViewController.swift
//  A11yDynamicType
//
//  Created by Winnie Teichmann on 2022-07-28.
//

import UIKit

class ConstraintsViewController: UIViewController {

    private var useCorrectConstraints = false

    private lazy var label: UILabel = .build { label in
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.accessibilityIdentifier = AccessibilityIdentifiers.ConstraintExample.brokenLabel
    }

    private lazy var label2: UILabel = .build { label in
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.accessibilityIdentifier = AccessibilityIdentifiers.ConstraintExample.goodLabel
        label.isHidden = !self.useCorrectConstraints
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(preferredContentSizeChanged(_:)),
                                               name: UIContentSizeCategory.didChangeNotification,
                                               object: nil)

        updateLabels()
    }

    @objc func preferredContentSizeChanged(_ notification: Notification) {
        updateLabels()
    }

    private func updateLabels() {
        label.text = "I am a \(traitCollection.preferredContentSizeCategory.rawValue)"
        label2.text = "I am a \(traitCollection.preferredContentSizeCategory.rawValue)"
    }

    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(label)
        view.addSubview(label2)
        setupConstraints()
    }

    private func setupConstraints() {
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: guide.topAnchor, constant: 40),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            label2.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 80),
            label2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label2.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor),
            label2.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor),
            label2.bottomAnchor.constraint(lessThanOrEqualTo: guide.bottomAnchor)
        ])
    }
}

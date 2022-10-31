//
//  HeightViewController.swift
//  A11yDynamicType
//
//  Created by Winnie Teichmann on 2022-07-28.
//

import UIKit

class HeightViewController: UIViewController {

    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.titleLabel?.numberOfLines = 1

        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.clipsToBounds = true
        button.backgroundColor = .lightGray
        button.contentEdgeInsets = UIEdgeInsets(top: 10,
                                                left: 10,
                                                bottom: 10,
                                                right: 10)
        button.layer.cornerRadius = 5.0
        return button
    }()

    private lazy var button2: ResizableButton = {
        let button = ResizableButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.titleLabel?.numberOfLines = 0

        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.clipsToBounds = true
        button.backgroundColor = .lightGray
        button.contentEdgeInsets = UIEdgeInsets(top: 10,
                                                left: 10,
                                                bottom: 10,
                                                right: 10)
        button.layer.cornerRadius = UIFontMetrics.default.scaledValue(for: 5) // scale the rounded corners
        button.isHidden = true
        return button
    }()

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        button.setTitle("I am a wonderful button", for: .normal)
        button2.setTitle("I am a wonderful button 2", for: .normal)
    }

    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(button)
        view.addSubview(button2)
        setupConstraints()
    }

    private func setupConstraints() {
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: guide.topAnchor, constant: 40),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            button.heightAnchor.constraint(equalToConstant: 40),

            button2.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 40),
            button2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            button2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            button2.bottomAnchor.constraint(lessThanOrEqualTo: guide.bottomAnchor)
        ])
    }
}

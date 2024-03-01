//
//  HeightViewController.swift
//  A11yDynamicType
//
//  Created by Winnie Teichmann on 2022-07-28.
//

import UIKit

class HeightViewController: UIViewController {

    private var useCorrectConstraints = false

    private lazy var button: UIButton = .build { button in
        var configuration = UIButton.Configuration.filled()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                              leading: 10,
                                                              bottom: 10,
                                                              trailing: 10)
        configuration.title = "I am a wonderful button"
        configuration.titleAlignment = .center
        configuration.titleLineBreakMode = .byWordWrapping
        configuration.baseForegroundColor = .black
        configuration.baseBackgroundColor = .lightGray
        configuration.background.cornerRadius = 5.0
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { [weak self] incoming in
            var container = incoming
            container.font = UIFont.preferredFont(forTextStyle: .body)
            return container
        }

        button.configuration = configuration
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.clipsToBounds = true
    }

    private lazy var button2: UIButton = .build { button in
        var configuration = UIButton.Configuration.filled()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                              leading: 10,
                                                              bottom: 10,
                                                              trailing: 10)
        configuration.title = "I am a wonderful button 2"
        configuration.titleAlignment = .center
        configuration.titleLineBreakMode = .byWordWrapping
        configuration.baseForegroundColor = .black
        configuration.baseBackgroundColor = .lightGray
        configuration.background.cornerRadius = 5.0
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { [weak self] incoming in
            var container = incoming
            container.font = UIFont.preferredFont(forTextStyle: .body)
            return container
        }

        button.configuration = configuration
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.isHidden = !self.useCorrectConstraints
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
            button2.bottomAnchor.constraint(lessThanOrEqualTo: guide.bottomAnchor),
        ])
    }
}

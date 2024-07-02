//
//  RelayoutViewController.swift
//  A11yDynamicType
//
//  Created by Winnie Teichmann on 2022-07-28.
//

import UIKit

class RelayoutViewController: UIViewController {

    private var useCorrectConstraints = false

    private var imageWidthConstraint: NSLayoutConstraint!

    private lazy var scrollView: UIScrollView = .build()
    private lazy var contentView: UIView = .build()

    private lazy var stackView: UIStackView = .build { view in
        view.axis = .horizontal
        view.spacing = 20
        view.distribution = .fill
        view.alignment = .top
    }

    private lazy var cardContentView: UIView = .build()

    private lazy var imageView: UIImageView = .build { view in
        view.image = UIImage(named: "mozilla-private-search")
        view.adjustsImageSizeForAccessibilityContentSizeCategory = true
        view.accessibilityIdentifier = AccessibilityIdentifiers.RelayoutExample.cardImage
    }

    private lazy var label: UILabel = .build { label in
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.accessibilityIdentifier = AccessibilityIdentifiers.RelayoutExample.cardText
    }

    private lazy var button: UIButton = .build { button in
        var configuration = UIButton.Configuration.filled()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                              leading: 10,
                                                              bottom: 10,
                                                              trailing: 10)
        configuration.title = "Learn more"
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
        button.accessibilityIdentifier = AccessibilityIdentifiers.RelayoutExample.cardButton
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(preferredContentSizeChanged(_:)),
                                               name: UIContentSizeCategory.didChangeNotification,
                                               object: nil)

        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc eget scelerisque mi, vitae bibendum sapien. Proin sodales orci quis mi laoreet, quis dignissim mi elementum."
    }

    @objc func preferredContentSizeChanged(_ notification: Notification) {
        guard useCorrectConstraints else { return }
        imageWidthConstraint?.constant = UIFontMetrics.default.scaledValue(for: 100) // scale the image

        if traitCollection.preferredContentSizeCategory.isAccessibilityCategory {
            stackView.axis = .vertical
        } else {
            stackView.axis = .horizontal
        }
    }

    private func setupView() {
        view.backgroundColor = .white

        cardContentView.addSubview(label)
        cardContentView.addSubview(button)

        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(cardContentView)

        contentView.addSubview(stackView)
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)

        setupConstraints()
    }

    private func setupConstraints() {
        let guide = view.safeAreaLayoutGuide
        imageWidthConstraint = imageView.widthAnchor.constraint(equalToConstant:
                                                                    UIFontMetrics.default.scaledValue(for: 100))
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: guide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                               constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                              constant: -16),

            imageWidthConstraint,
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0),

            label.topAnchor.constraint(equalTo: cardContentView.topAnchor),
            label.leadingAnchor.constraint(equalTo: cardContentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: cardContentView.trailingAnchor),

            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            button.leadingAnchor.constraint(equalTo: cardContentView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: cardContentView.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: cardContentView.bottomAnchor),
        ])
    }
}

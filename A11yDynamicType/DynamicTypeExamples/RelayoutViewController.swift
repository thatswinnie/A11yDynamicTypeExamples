//
//  RelayoutViewController.swift
//  A11yDynamicType
//
//  Created by Winnie Teichmann on 2022-07-28.
//

import UIKit

class RelayoutViewController: UIViewController {

    private var imageWidthConstraint: NSLayoutConstraint!

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .top
        return stackView
    }()

    private lazy var cardContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "mozilla-private-search"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        return imageView
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        return label
    }()

    private lazy var button: ResizableButton = {
        let button = ResizableButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.titleLabel?.numberOfLines = 0

        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.clipsToBounds = true
        button.backgroundColor = .lightGray
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.cornerRadius = UIFontMetrics.default.scaledValue(for: 5) // scale the rounded corners
        return button
    }()

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(preferredContentSizeChanged(_:)),
                                               name: UIContentSizeCategory.didChangeNotification,
                                               object: nil)

        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc eget scelerisque mi, vitae bibendum sapien. Proin sodales orci quis mi laoreet, quis dignissim mi elementum."
        button.setTitle("Learn more", for: .normal)
    }

    @objc func preferredContentSizeChanged(_ notification: Notification) {
//        imageWidthConstraint?.constant = UIFontMetrics.default.scaledValue(for: 100) // scale the image
//
//        if traitCollection.preferredContentSizeCategory.isAccessibilityCategory {
//            stackView.axis = .vertical
//        } else {
//            stackView.axis = .horizontal
//        }
    }

    private func setupView() {
        view.backgroundColor = .white

        contentView.addSubview(label)
        contentView.addSubview(button)

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

//
//  MovieDetailController.swift
//  TheMovieApp
//
//  Created by ferid on 11.02.25.
//

import UIKit

class MovieDetailController: UIViewController {

    var movie: MovieResult?
    var viewModel = MovieDetailsViewModel()

    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let languageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let runtimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let imdbLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Details", "Trailer", "Cast", "Shots"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()

    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var favoriteButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupBindings()
        setupFavoriteButton()
        viewModel.getMovieDetails()
    }

    private func setupUI() {
        view.addSubview(posterImageView)
        view.addSubview(titleLabel)
        view.addSubview(infoStackView)
        view.addSubview(segmentedControl)
        view.addSubview(contentLabel)

        infoStackView.addArrangedSubview(languageLabel)
        infoStackView.addArrangedSubview(runtimeLabel)
        infoStackView.addArrangedSubview(imdbLabel)

        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)

        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            posterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 350),
            posterImageView.heightAnchor.constraint(equalToConstant: 400),

            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            infoStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            infoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            segmentedControl.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            contentLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }

    private func setupBindings() {
        viewModel.success = { [weak self] in
            guard let self = self, let movieDetail = self.viewModel.movieDetail else { return }
            DispatchQueue.main.async {
                self.titleLabel.text = movieDetail.title
                self.languageLabel.text = "Language: \(movieDetail.originalLanguage?.uppercased() ?? "N/A")"
                let runtimeText = "\(movieDetail.runtime ?? 0) min"
                let attachment = NSTextAttachment()
                attachment.image = UIImage(systemName: "clock.fill")
                attachment.bounds = CGRect(x: 0, y: -4, width: 18, height: 18)
                let attributedString = NSMutableAttributedString(string: runtimeText)
                attributedString.append(NSAttributedString(attachment: attachment))
                self.runtimeLabel.attributedText = attributedString

                let ratingText = String(format: "%.1f/10", movieDetail.voteAverage ?? 0.0)
                let starAttachment = NSTextAttachment()
                starAttachment.image = UIImage(systemName: "star.fill")?.withTintColor(.blue)
                starAttachment.bounds = CGRect(x: 0, y: -1, width: 18, height: 18)
                let imdbString = NSMutableAttributedString(string: ratingText + " ")
                imdbString.append(NSAttributedString(attachment: starAttachment))
                self.imdbLabel.attributedText = imdbString

                if let posterPath = movieDetail.posterPath {
                    self.posterImageView.loadImage(url: posterPath)
                }

                self.contentLabel.text = movieDetail.overview
            }
        }

        viewModel.error = { errorMessage in
            self.showError(errorMessage)
        }
    }

    private func setupFavoriteButton() {
        let bookmarkImage = UIImage(systemName: "bookmark.fill")
        favoriteButton = UIBarButtonItem(image: bookmarkImage, style: .plain, target: self, action: #selector(favoriteButtonTapped))
        navigationItem.rightBarButtonItem = favoriteButton
    }

    @objc private func favoriteButtonTapped() {
        guard let movie = viewModel.movieDetail else {return}
        FirestoreManager.shared.saveMovie(movie: movie) { error in
            if let error {
                self.showAlert(message: error)
            } else {
                self.showAlert(title: "Success", message: "Save olundu")
            }
        }
    }

    @objc private func segmentChanged() {
        guard let movieDetail = viewModel.movieDetail else { return }

        switch segmentedControl.selectedSegmentIndex {
        case 0:
            contentLabel.text = movieDetail.overview
        case 1:
            contentLabel.text = "Trailer Link"
        case 2:
            contentLabel.text = "Cast Info"
        case 3:
            contentLabel.text = "Shots"
        default:
            break
        }
    }

    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

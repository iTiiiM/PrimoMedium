//
//  ViewController.swift
//  PrimoMedium
//
//  Created by Mew on 22/5/2568 BE.
//

import UIKit
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {
    
    var pageTitle = UILabel()
    var separatorView = UIView()
    var feedTableView = UITableView()
    let viewModel = HomeViewModel(
        loadArticleUseCase: LoadArticleUseCaseImpl(
            defaultArticleRepository: DefaultArticleRepository()
        )
    )
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupTableView()
        bindOutput()
        viewModel.bindViewModel()
        bindInput()
    }
    
    func bindInput() {
    
        viewModel.viewDidLoad.accept(())
    }
    
    func bindOutput() {
        viewModel.articles.drive(feedTableView.rx.items(cellIdentifier: "BlogPostCell")) { index, article, cell in
            guard let cell = cell as? BlogPostCell else { return }
            cell.configure(with: article)
        }.disposed(by: disposeBag)
        
        
        
        feedTableView.rx.modelSelected(Article.self)
            .withUnretained(self)
            .subscribe(onNext: { article in

                let vc = ReaderWebViewController()
                vc.articleContent = "<p>Google has recently expanded its <strong>Gemini 2.0</strong> model family...</p>"
                
                self.present(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupViews() {
        pageTitle.text = "To be retrieved by API"
        pageTitle.font = UIFont.boldSystemFont(ofSize: 26)
        separatorView.backgroundColor = .black
        
        pageTitle.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        feedTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(pageTitle)
        view.addSubview(separatorView)
        view.addSubview(feedTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            pageTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            pageTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            pageTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            separatorView.topAnchor
                .constraint(equalTo: pageTitle.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 2),
            
            feedTableView.topAnchor
                .constraint(equalTo: separatorView.bottomAnchor, constant: 32),
            feedTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            feedTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            feedTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
//        feedTableView.dataSource = self
//        feedTableView.delegate = self
        feedTableView.register(BlogPostCell.self, forCellReuseIdentifier: "BlogPostCell")
    }
}

//
//extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.blogPosts.count
//    }
//
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        guard let cell = tableView.dequeueReusableCell(
////            withIdentifier: "BlogPostCell",
////            for: indexPath
////        ) as? BlogPostCell else { return UITableViewCell() }
////        cell.configure(with: viewModel.blogPosts[indexPath.row])
////        return cell
////    }
//
//    func tableView(
//        _ tableView: UITableView,
//        didSelectRowAt indexPath: IndexPath
//    ) {
//        let vc = ReaderWebViewController()
//        vc.articleContent = "<p>Google has recently expanded its <strong>Gemini 2.0</strong> model family...</p>"
//    
//        present(vc, animated: true)
//    }
//}

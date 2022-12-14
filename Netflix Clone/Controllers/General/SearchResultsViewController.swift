//
//  SearchResultsViewController.swift
//  Netflix Clone
//
//  Created by Caner Çağrı on 20.12.2022.
//

import UIKit


protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewControllerDidTapItem(_ model: TitlePreviewViewModel)
}


class SearchResultsViewController: UIViewController {
    
    public var titles: [Title] = [Title]()
    
    weak var delegate: SearchResultsViewControllerDelegate?
    
    public let searchResultsCollectionView: UICollectionView = {
        
        var layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(searchResultsCollectionView)
        
        searchResultsCollectionView.dataSource = self
        searchResultsCollectionView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }
}

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else { return UICollectionViewCell() }
        
        let title = titles[indexPath.row]
        cell.configure(with: title.poster_path ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        
        
        let title = titles[indexPath.row]
        
        
        let titleName = title.original_title ?? ""
        
        print(titleName)
        
        APICaller.shared.getMovie(with: titleName) { [weak self] result in
            switch result {
            case .success(let video):
                DispatchQueue.main.async {
                    self?.delegate?.searchResultsViewControllerDidTapItem(TitlePreviewViewModel(title: titleName, youtubeView: video, titleOverview: title.overview ?? ""))
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

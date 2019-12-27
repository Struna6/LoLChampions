//
//  ViewController.swift
//  LoLChampions
//
//  Created by Karol on 25/12/2019.
//  Copyright © 2019 Karol. All rights reserved.
//

import UIKit
import SnapKit

class ChampionsViewController: UIViewController {
    var championsTableView : ChampionsTableView!
    var championsLoader : ChampionLoader!
    var loadingView : LoadingView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "League of Legends Champions"
        
        configureChampionsTableView()
        configureChampionsLoader()
        configureLoadingView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureChampionsTableViewConstraints()
        configureLoadingViewConstraints()
    }
    
    init(championsLoader : ChampionLoader = ChampionLoaderImpl()){
        self.championsLoader = championsLoader
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Configuration of ChampionsTableView
extension ChampionsViewController{
    private func configureChampionsTableView(){
        championsTableView = ChampionsTableView()
        view.addSubview(championsTableView)
        championsTableView.delegate = self
        championsTableView.dataSource = self
        championsTableView.register(ChampionTableViewCell.self, forCellReuseIdentifier: "championCell")
        championsTableView.rowHeight = UITableView.automaticDimension
        championsTableView.estimatedRowHeight = 80
    }
    
    private func configureChampionsTableViewConstraints(){
        championsTableView.translatesAutoresizingMaskIntoConstraints = false
        championsTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

//MARK: Configuration of ChampionsLoader
extension ChampionsViewController{
    private func configureChampionsLoader(){
        championsLoader.delegate = self
    }
}

//MARK: Configuration of LoadingView
extension ChampionsViewController{
    private func configureLoadingView(){
        loadingView = LoadingView()
        view.addSubview(loadingView)
    }
    
    private func configureLoadingViewConstraints(){
        guard loadingView.superview != nil else {return}
        loadingView?.snp.makeConstraints(){
            $0.edges.equalToSuperview()
        }
    }
}

//MARK: Conforming to TableView delegates
extension ChampionsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return championsLoader.champions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "championCell", for: indexPath) as? ChampionTableViewCell else {fatalError()}
        let champion = championsLoader.champions?[indexPath.row]
        guard champion != nil else {fatalError()}
        
        cell.champName.text = champion?.name
        cell.role1ImageView.image = champion?.roles.first?.image
        cell.role2ImageView.image = (champion?.roles.count ?? 0) > 1 ? champion?.roles.last?.image : nil
        let name = ((champion?.name ?? "").onlyCharacters(charSet: .letters).capitalized) + "_0"
        cell.champThumbnail.image = UIImage(named: name)
        cell.type1ImageView.image = champion?.type.first?.image
        cell.type2ImageView.image = (champion?.type.count ?? 0) > 1 ? champion?.type.last?.image : nil
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let champion = championsLoader.champions?[indexPath.row]
        guard champion != nil else {return}
        showDetailsVC(with: champion!)
    }
}

//MARK: Conforming to ChampionsLoader delegates
extension ChampionsViewController: ChampionLoaderImplDelegate{
    func championsLoadingFinishedSuccesfully() {
        loadingView.dismiss()
        championsTableView.reloadData()
    }
    
    func championsloadingFailed() {
        
    }
}

//MARK: Handle detailsVC
extension ChampionsViewController{
    func showDetailsVC(with champion: Champion){
        let detailsVC = ChampionDetailsViewController()
        detailsVC.selectedChampion = champion
        detailsVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}

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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        championsTableView = ChampionsTableView()
        view.addSubview(championsTableView)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureChampionsTableViewConstraints()
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Configuration of ChampionsTableView
    
    private func configureChampionsTableView(){
        
    }
    
    private func configureChampionsTableViewConstraints(){
        championsTableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}


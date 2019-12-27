//
//  BootomStatView.swift
//  LoLChampions
//
//  Created by Karol on 27/12/2019.
//  Copyright © 2019 Karol. All rights reserved.
//

import UIKit
import SnapKit

protocol StatViewDataSource: class{
    var attack: Int {get}
    var defence: Int {get}
    var magic: Int {get}
    var difficulty: Int {get}
}

class StatView: UIView {
    override var isHidden: Bool{
        willSet{
            if newValue{
                reload()
            }
        }
    }
    
    private var stackView : UIStackView!
    weak var dataSource : StatViewDataSource?
    private let attackLabel = UILabel()
    private let defenceLabel = UILabel()
    private let magicLabel = UILabel()
    private let difficulty = UILabel()

    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        let imageView1 = UIImageView(image: UIImage(named: "AD"))
        let imageView2 = UIImageView(image: UIImage(named: "defence"))
        let imageView3 = UIImageView(image: UIImage(named: "AP"))
        let imageView4 = UIImageView(image: UIImage(named: "difficulty"))
        imageView1.contentMode = .scaleAspectFit
        imageView2.contentMode = .scaleAspectFit
        imageView3.contentMode = .scaleAspectFit
        imageView4.contentMode = .scaleAspectFit
        
        let VStack1 = UIStackView(arrangedSubviews: [imageView1, attackLabel])
        let VStack2 = UIStackView(arrangedSubviews: [imageView2, defenceLabel])
        let VStack3 = UIStackView(arrangedSubviews: [imageView3, magicLabel])
        let VStack4 = UIStackView(arrangedSubviews: [imageView4, difficulty])
        VStack1.axis = .vertical
        VStack2.axis = .vertical
        VStack3.axis = .vertical
        VStack4.axis = .vertical
        VStack1.distribution = .fillEqually
        VStack2.distribution = .fillEqually
        VStack3.distribution = .fillEqually
        VStack4.distribution = .fillEqually
        
        attackLabel.textAlignment = .center
        defenceLabel.textAlignment = .center
        magicLabel.textAlignment = .center
        difficulty.textAlignment = .center
        
        attackLabel.numberOfLines = 0
        defenceLabel.numberOfLines = 0
        magicLabel.numberOfLines = 0
        difficulty.numberOfLines = 0
        
        stackView = UIStackView(arrangedSubviews: [VStack1,VStack2,VStack3,VStack4])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.snp.makeConstraints(){
            $0.edges.equalToSuperview()
        }
    }
    
    func reload(){
        attackLabel.text = "Attack:\n" + String(dataSource?.attack ?? 0)
        defenceLabel.text = "Defense:\n" + String(dataSource?.defence ?? 0)
        magicLabel.text = "Magic:\n" + String(dataSource?.magic ?? 0)
        difficulty.text = "Difficulty:\n" + String(dataSource?.difficulty ?? 0)
    }
}

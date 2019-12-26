//
//  ChampionTableViewCell.swift
//  LoLChampions
//
//  Created by Karol on 26/12/2019.
//  Copyright © 2019 Karol. All rights reserved.
//

import UIKit
import SnapKit

class ChampionTableViewCell: UITableViewCell {
    var role1ImageView = UIImageView()
    var role2ImageView = UIImageView()
    var type1ImageView = UIImageView()
    var type2ImageView = UIImageView()
    private var leftHStack : UIStackView!
    private var leftVStack : UIStackView!
    private var rightVStack : UIStackView!
    var champThumbnail : UIImageView!
    var champName : UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureElements()
    }
    
    private func configureElements(){
        leftHStack = UIStackView(arrangedSubviews: [role1ImageView, role2ImageView])
        leftHStack.axis = .horizontal
        leftHStack.distribution = .fillEqually
        leftHStack.alignment = .center
        
        champName = UILabel()
        champName.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 24.0)
        champName.textAlignment = .left
        
        leftVStack = UIStackView(arrangedSubviews: [leftHStack, champName])
        leftVStack.axis = .vertical
        leftVStack.alignment = .center
        contentView.addSubview(leftVStack)
        
        role1ImageView.contentMode = .scaleAspectFit
        role2ImageView.contentMode = .scaleAspectFit
        
        role1ImageView.snp.makeConstraints(){
            $0.height.equalTo(champName.snp.height).multipliedBy(1.2)
        }
        
        role2ImageView.snp.makeConstraints(){
            $0.height.equalTo(champName.snp.height).multipliedBy(1.2)
        }
        
        leftVStack.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4)
            make.bottomMargin.equalToSuperview().priority(999)
            make.topMargin.equalToSuperview().priority(999)
            make.height.equalTo(80)
        }
        
        champThumbnail = UIImageView()
        champThumbnail.contentMode = .scaleAspectFit
        contentView.addSubview(champThumbnail)
        
        champThumbnail.snp.makeConstraints(){
            $0.trailing.equalToSuperview()
            $0.bottomMargin.equalToSuperview().priority(999)
            $0.topMargin.equalToSuperview().priority(999)
            $0.width.equalTo(80)
            $0.height.equalTo(80)
        }
        
        type1ImageView.contentMode = .scaleAspectFit
        type2ImageView.contentMode = .scaleAspectFit
        rightVStack = UIStackView(arrangedSubviews: [type1ImageView, type2ImageView])
        rightVStack.axis = .vertical
        rightVStack.distribution = .fillEqually
        contentView.addSubview(rightVStack)
        
        rightVStack.snp.makeConstraints(){
            $0.height.equalTo(80)
            $0.right.equalTo(champThumbnail.snp.left).offset(-10)
            $0.width.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        type1ImageView.image = nil
        type2ImageView.image = nil
        role1ImageView.image = nil
        role2ImageView.image = nil
    }
}

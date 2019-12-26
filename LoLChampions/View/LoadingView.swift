//
//  LoadingView.swift
//  LoLChampions
//
//  Created by Karol on 26/12/2019.
//  Copyright © 2019 Karol. All rights reserved.
//

import UIKit
import SnapKit

class LoadingView: UIView {
    let blur = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
    var loader : UIActivityIndicatorView!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(){
        if self.alpha == 1.0{
            self.loader.startAnimating()
        }else{
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                self?.alpha = 1.0
            }) {[weak self] (_) in
                self?.loader.startAnimating()
            }
        }
    }
    
    func dismiss(){
        self.loader.stopAnimating()
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.alpha = 0.0
        }) {[weak self] (_) in
            self?.removeFromSuperview()
        }
    }
    
    init(){
        super.init(frame: .zero)
        configure()
    }
    
    private func configure(){
        self.addSubview(blur)
        blur.snp.makeConstraints(){
            $0.edges.equalToSuperview()
        }
        
        loader = UIActivityIndicatorView()
        loader.color = .label
        blur.contentView.addSubview(loader)
        loader.snp.makeConstraints(){
            $0.width.equalTo(100)
            $0.height.equalTo(100)
            $0.center.equalToSuperview()
        }
        show()
    }
}

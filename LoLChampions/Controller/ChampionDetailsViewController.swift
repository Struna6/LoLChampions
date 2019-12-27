//
//  ChampionDetailsViewController.swift
//  LoLChampions
//
//  Created by Karol on 26/12/2019.
//  Copyright © 2019 Karol. All rights reserved.
//

import UIKit
import SnapKit

class ChampionDetailsViewController: UIViewController {
    var selectedChampion : Champion!
    var backgroudImageView : UIImageView!
    var topLabel : UILabel!
    var bottomStatView : StatView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureBackgroudImage()
        configureTopLabel()
        configureBottomStatView()
        makeTapHandler()
        makeSwipeHandler()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureBackgroudImageConstraints()
        configureTopLabelConstraints()
        configureBottomStatViewConstraints()
    }
}

//MARK: Configuration of BackgroudImageView
extension ChampionDetailsViewController{
    private func configureBackgroudImage(){
        let name = (selectedChampion.name.onlyCharacters(charSet: .letters).capitalized) + "_1"
        let image = UIImage(named: name)
        backgroudImageView = UIImageView(image: image)
        backgroudImageView.contentMode = .scaleAspectFit
        view.addSubview(backgroudImageView)
    }
    
    private func configureBackgroudImageConstraints(){
        backgroudImageView.snp.makeConstraints(){
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

//MARK: Configuration of TopLabel
extension ChampionDetailsViewController{
    private func configureTopLabel(){
        topLabel = UILabel()
        topLabel.text = selectedChampion.name
        topLabel.textAlignment = .center
        topLabel.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 30.0)
        topLabel.backgroundColor = .systemBackground
        backgroudImageView.addSubview(topLabel)
    }
    
    private func configureTopLabelConstraints(){
        topLabel.snp.makeConstraints(){
            $0.left.equalToSuperview()
            $0.top.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
}

//MARK: Configuration and conformance of BottomStatView
extension ChampionDetailsViewController: StatViewDataSource{
    var attack: Int {
        0
    }
    
    var defence: Int {
        0
    }
    
    var magic: Int {
        0
    }
    
    var difficulty: Int {
        0
    }
    
    private func configureBottomStatView(){
        bottomStatView = StatView()
        bottomStatView.isHidden = true
        bottomStatView.dataSource = self
        backgroudImageView.addSubview(bottomStatView)
    }
    
    private func configureBottomStatViewConstraints(){
        bottomStatView.snp.makeConstraints(){
            $0.left.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(200)
        }
    }
}

//MARK: Configuration of TapHandle
extension ChampionDetailsViewController{
    func makeTapHandler(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ tap: UIGestureRecognizer){
        if tap.state == .recognized{
            if bottomStatView.isHidden{
                let name = (selectedChampion.name.onlyCharacters(charSet: .letters).capitalized) + "_2"
                var image = UIImage(named: name)
                if backgroudImageView.image == image{
                    let name = (selectedChampion.name.onlyCharacters(charSet: .letters).capitalized) + "_1"
                    image = UIImage(named: name)
                }
                backgroudImageView.image = image
            }else{
                bottomStatView.isHidden = true
            }
        }
    }
}

//MARK: Configuration of SwipeUp
extension ChampionDetailsViewController{
    func makeSwipeHandler(){
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe(_:)))
        swipe.direction = .up
        swipe.delegate = self
        view.addGestureRecognizer(swipe)
    }
    
    @objc func handleSwipe(_ tap: UIGestureRecognizer){
        if tap.state == .ended{
            bottomStatView.isHidden = false
        }
    }
}

//MARK: Configuration of GesturesDelegate
extension ChampionDetailsViewController: UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        (gestureRecognizer is UISwipeGestureRecognizer) && (otherGestureRecognizer is UITapGestureRecognizer)
    }
}

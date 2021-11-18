//
//  ViewController.swift
//  PagerView_tutorial
//
//  Created by 장민석 on 2021/11/18.
//  Copyright © 2021 장민석. All rights reserved.
//

import UIKit
import FSPagerView

class ViewController: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate{
    
    fileprivate let imageNames = ["1.jpeg", "2.jpeg", "3.jpeg", "4.jpeg"]
    
    @IBOutlet weak var leftBtn: UIButton!
    
    @IBOutlet weak var rightBtn: UIButton!
    
    @IBOutlet weak var myPagerView: FSPagerView!{
        didSet{
            // 페이저뷰에 셀을 등록한다.
            self.myPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            // 아이템 크기 설정
            self.myPagerView.itemSize = FSPagerView.automaticSize;
            // 무한 스크롤 설정
            self.myPagerView.isInfinite = true
            // 자동 스크롤 설정
            self.myPagerView.automaticSlidingInterval = 4.0
        }
    }
    
    @IBOutlet weak var myPageControl: FSPageControl!{
        didSet{
            self.myPageControl.numberOfPages = self.imageNames.count
            self.myPageControl.contentHorizontalAlignment = .right
            self.myPageControl.itemSpacing = 16
            self.myPageControl.interitemSpacing = 16
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.myPagerView.dataSource = self
        self.myPagerView.delegate = self
        
        self.leftBtn.layer.cornerRadius = self.leftBtn.frame.height / 2
        self.rightBtn.layer.cornerRadius = self.rightBtn.frame.height / 2
        
        
    }
    
    // MARK: - IBActions
    @IBAction func onLeftBtnClicked(_ sender: UIButton) {
        print("ViewController - onLeftBtnClicked() called")
        
        self.myPageControl.currentPage = self.myPageControl.currentPage - 1
        
        self.myPagerView.scrollToItem(at: self.myPageControl.currentPage, animated: true)
    }
    
    @IBAction func onRightBtnClicked(_ sender: UIButton) {
        print("ViewController - onRightBtnClicked() called")
        
        if(self.myPageControl.currentPage == self.imageNames.count - 1){
            self.myPageControl.currentPage = 0
        } else{
            self.myPageControl.currentPage = self.myPageControl.currentPage + 1
        }
        
        self.myPagerView.scrollToItem(at: self.myPageControl.currentPage, animated: true)
    }
    
    // MARK: - FSPagerView Datasource
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageNames.count
    }
    
    // 각 셀에 대한 설정
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFit
        return cell
    }

    // MARK: - FSPagerView Delegate
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.myPageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.myPageControl.currentPage = pagerView.currentIndex
    }
    
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return false
    }
    
}


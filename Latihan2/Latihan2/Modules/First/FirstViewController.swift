//
//  FirstViewController.swift
//  Latihan2
//
//  Created by Macbook Pro on 20/03/23.
//

import UIKit

class FirstViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var timer : Timer?
    
    
    var onboardingList : [Onboarding] = []
    //viewdidload untuk entrypoint di viewcontroller, dalam 1 lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadOnboardingList()
        
        // Do any additional setup after loading the view.
        //setelah disambungkan di onboardingviewcontroller
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //timer
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: {
            [weak self] _ in
            
            guard let `self` = self else { return}
            
            let currentPage = Int(self.collectionView.contentOffset.x / self.collectionView.frame.width)
            let nextPage = currentPage + 1 >= self.onboardingList.count ? 0 : currentPage +  1
            let indexPath = IndexPath(item : nextPage, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.pageControl.currentPage = nextPage
        })
    
    }
    deinit {
        timer?.invalidate()
    }
    
    //MARK - Actions
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
       showPinViewController()
    }
    
  
    
    //MARK - UICollectionViewDataSource
    
    //function untuk me,mberi tahu berapa banyak data yang akan ditampilkan (jumlah data)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingList.count
    }
    
    
    //datanya apa, menampilkan valuenya, ngembalikin datanya UICell, data yang udah diisi
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //dibikin dulu variabelnya, ditampung di var cell , cell apa? jadi harus di cast Onboardingviewcell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onboardingitemvalue", for: indexPath) as! OnboardingViewCell
        
        //baru di panggil valuenya, isi item yg ada di on boarding list
        let onboarding = onboardingList[indexPath.item]
        cell.imageView.image = UIImage(named: onboarding.image)
        cell.titleLabel.text = onboarding.title
        cell.subtitleLabel.text = onboarding.subtitle
        
        return cell
    }
    
    //MARK - UICollectionViewDelegateFlowLayout
    
    //antar baris
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 0
    }
    
    
    //antar item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        
//        let width = floor(UIScreen.main.bounds.width/2) screen bagi 2
        return CGSize(width: width, height: 500)
    }
    
    //MARK - UICollectionViewDelegate
    //indikator status scroll
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //karena horizontal jadi x width
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = page
    }
    
    //MARK - Actions
    
    
    
    
    @IBAction func pageControlValueChanged(_ sender: Any) {
        let page = pageControl.currentPage
        collectionView.scrollToItem(at: IndexPath(item:page,section: 0), at: .centeredHorizontally, animated: true)
    }
    //MARK - Helpers
    
    //ambil data untuk disimpan di onboarding
    
    func loadOnboardingList(){
        onboardingList = [
            Onboarding(image: "img_onboarding1", title: "Gain total control of your money", subtitle: "Become your own money manager and make every cent count"),
            Onboarding(image: "img_onboarding2", title: "Know where your money goes", subtitle: "Track your transaction easily, with categories and financial report"),
            Onboarding(image: "img_onboarding3", title: "Planning ahead", subtitle: "Setup your budget for each category so you in control"),
        
        ]
        
        //atau bisa di code di viewdidload
        pageControl.numberOfPages = onboardingList.count
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

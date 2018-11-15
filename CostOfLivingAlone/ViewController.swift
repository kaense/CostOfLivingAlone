//
//  ViewController.swift
//  CostOfLivingAlone
//
//  Created by 田中良明 on 2018/10/02.
//  Copyright © 2018年 tanakayoshiaki. All rights reserved.
//


import UIKit
import GoogleMobileAds

class ViewController: UIViewController, UITextFieldDelegate,GADBannerViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    // 現在選択されているTextField
    var selectedTextField:UITextField?
    
    
    let AdMobTest:Bool = false
    
    @IBOutlet var subBannerView: UIView!
    var bannerView: GADBannerView!
    
    @IBOutlet var total: UILabel!
    @IBOutlet var income: UITextField!{
        didSet {
            income?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForIncome)))
        }
    }
    @IBOutlet var rent: UITextField!{
        didSet {
            rent?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForRent)))
        }
    }
    @IBOutlet var food: UITextField!{
        didSet {
            food?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForFood)))
        }
    }
    @IBOutlet var energy: UITextField!{
        didSet {
            energy?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForEnergy)))
        }
    }
    @IBOutlet var phone: UITextField!{
        didSet {
            phone?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForPhone)))
        }
    }
    @IBOutlet var friendly: UITextField!{
        didSet {
            friendly?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForFriendly)))
        }
    }
    @IBOutlet var etc: UITextField!{
        didSet {
            etc?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForEtc)))
        }
    }
    @IBOutlet var livingTax: UITextField!{
        didSet {
            livingTax?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForLivingTax)))
        }
    }
    @IBOutlet var pension: UITextField!{
        didSet {
            pension?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForPension)))
        }
    }
    @IBOutlet var health: UITextField!{
        didSet {
            health?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForHealth)))
        }
    }
    @IBOutlet var incomeTax: UITextField!{
        didSet {
            incomeTax?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForIncomeTax)))
        }
    }
    @IBOutlet var etcTax: UITextField!{
        didSet {
            etcTax?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForEtcTax)))
        }
    }
    
    @objc func doneButtonTappedForIncome() {
        income.resignFirstResponder()
    }
    @objc func doneButtonTappedForFood() {
        food.resignFirstResponder()
    }
    @objc func doneButtonTappedForRent() {
        rent.resignFirstResponder()
    }
    @objc func doneButtonTappedForEnergy() {
        energy.resignFirstResponder()
    }
    @objc func doneButtonTappedForPhone() {
        phone.resignFirstResponder()
    }
    @objc func doneButtonTappedForFriendly() {
        friendly.resignFirstResponder()
    }
    @objc func doneButtonTappedForEtc() {
        etc.resignFirstResponder()
    }
    @objc func doneButtonTappedForLivingTax() {
        livingTax.resignFirstResponder()
    }
    @objc func doneButtonTappedForPension() {
        pension.resignFirstResponder()
    }
    @objc func doneButtonTappedForHealth() {
        health.resignFirstResponder()
    }
    @objc func doneButtonTappedForIncomeTax() {
        incomeTax.resignFirstResponder()
    }
    @objc func doneButtonTappedForEtcTax() {
        etcTax.resignFirstResponder()
    }
    
    // UserDefaults のインスタンス
    let userDefaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // キーボードイベントの監視開始
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeShown(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeHidden(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        // キーボードイベントの監視解除
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    // キーボード以外をタップするとキーボードが下がるメソッド
    @objc func hideKyeoboardTap(recognizer : UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tapされた時の動作を宣言する: 一度タップされたらキーボードを隠す
        let hideTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKyeoboardTap))
        hideTap.numberOfTapsRequired = 1
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)
        
        // デフォルト値
        userDefaults.register(defaults: ["income": "120000" ])
        userDefaults.register(defaults: ["rent": "50000" ])
        userDefaults.register(defaults: ["food": "30000" ])
        userDefaults.register(defaults: ["energy": "10000" ])
        userDefaults.register(defaults: ["friendly": "5000" ])
        userDefaults.register(defaults: ["etc": "0" ])
        userDefaults.register(defaults: ["livingTax": "0" ])
        userDefaults.register(defaults: ["pension": "0" ])
        userDefaults.register(defaults: ["health": "0" ])
        userDefaults.register(defaults: ["incomeTax": "0" ])
        userDefaults.register(defaults: ["etcTax": "0" ])
        userDefaults.register(defaults: ["phone": "0" ])

        // Keyを指定して読み込み
        income.text = (userDefaults.object(forKey: "income") as! String)
        rent.text = (userDefaults.object(forKey: "rent") as! String)
        food.text = (userDefaults.object(forKey: "food") as! String)
        energy.text = (userDefaults.object(forKey: "energy") as! String)
        friendly.text = (userDefaults.object(forKey: "friendly") as! String)
        etc.text = (userDefaults.object(forKey: "etc") as! String)
        livingTax.text = (userDefaults.object(forKey: "livingTax") as! String)
        pension.text = (userDefaults.object(forKey: "pension") as! String)
        health.text = (userDefaults.object(forKey: "health") as! String)
        incomeTax.text = (userDefaults.object(forKey: "incomeTax") as! String)
        etcTax.text = (userDefaults.object(forKey: "etcTax") as! String)
        phone.text = (userDefaults.object(forKey: "phone") as! String)
        
        
        // In this case, we instantiate the banner with desired ad size.
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        
        //subBannerView.addSubview(bannerView)
        
        addBannerViewToView(bannerView)
        
        self.income.keyboardType = UIKeyboardType.numberPad
        self.rent.keyboardType = UIKeyboardType.numberPad
        self.food.keyboardType = UIKeyboardType.numberPad
        self.energy.keyboardType = UIKeyboardType.numberPad
        self.friendly.keyboardType = UIKeyboardType.numberPad
        self.etc.keyboardType = UIKeyboardType.numberPad
        self.livingTax.keyboardType = UIKeyboardType.numberPad
        self.pension.keyboardType = UIKeyboardType.numberPad
        self.health.keyboardType = UIKeyboardType.numberPad
        self.incomeTax.keyboardType = UIKeyboardType.numberPad
        self.etcTax.keyboardType = UIKeyboardType.numberPad
        self.phone.keyboardType = UIKeyboardType.numberPad

        income.delegate = self
        rent.delegate = self
        food.delegate = self
        energy.delegate = self
        friendly.delegate = self
        etc.delegate = self
        livingTax.delegate = self
        pension.delegate = self
        health.delegate = self
        incomeTax.delegate = self
        etcTax.delegate = self
        phone.delegate = self
    
        
        if AdMobTest {
            bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        }else{
            bannerView.adUnitID = "ca-app-pub-6789227322694215/7806624757"
        }
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
        calculate(0)
        
    }
    

    @IBAction func calculateIncome(_ sender: UITextField){
        // Keyを指定して保存
        userDefaults.set(income.text, forKey: "income")
        calculate(0)
    }
    @IBAction func calculateRent(_ sender: UITextField) {
        // Keyを指定して保存
        userDefaults.set(rent.text, forKey: "rent")
        calculate(0)
    }
    @IBAction func calculateFood(_ sender: UITextField) {
        // Keyを指定して保存
        userDefaults.set(food.text, forKey: "food")
        calculate(0)
    }
    @IBAction func calculateEnergy(_ sender: UITextField) {
        // Keyを指定して保存
        userDefaults.set(energy.text, forKey: "energy")
        calculate(0)
    }
    @IBAction func calculatePhone(_ sender: UITextField) {
        // Keyを指定して保存
        userDefaults.set(phone.text, forKey: "phone")
        calculate(0)
    }

    @IBAction func calculateFriendly(_ sender: UITextField) {
        // Keyを指定して保存
        userDefaults.set(friendly.text, forKey: "friendly")
        calculate(0)
    }
    @IBAction func calculateEtc(_ sender: UITextField) {
        // Keyを指定して保存
        userDefaults.set(etc.text, forKey: "etc")
        calculate(0)
    }
    @IBAction func calculateLivingTax(_ sender: UITextField) {
        // Keyを指定して保存
        userDefaults.set(livingTax.text, forKey: "livingTax")
        calculate(0)
    }
    @IBAction func calculatePension(_ sender: UITextField) {
        // Keyを指定して保存
        userDefaults.set(pension.text, forKey: "pension")
        calculate(0)
    }
    @IBAction func calculateHealth(_ sender: UITextField) {
        // Keyを指定して保存
        userDefaults.set(health.text, forKey: "health")
        calculate(0)
    }
    @IBAction func calculateIncomeTax(_ sender: UITextField) {
        // Keyを指定して保存
        userDefaults.set(incomeTax.text, forKey: "incomeTax")
        calculate(0)
    }
    @IBAction func calculateEtcTax(_ sender: UITextField) {
        // Keyを指定して保存
        userDefaults.set(etcTax.text, forKey: "etcTax")
        calculate(0)
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func calculate(_ sender: Any) {
        // データの同期
        userDefaults.synchronize()
        
        let resultIncome:Int? = Int(income.text!)
        let resultRent:Int? = Int(rent.text!)
        let resultFood:Int? = Int(food.text!)
        let resultEnergy:Int? = Int(energy.text!)
        let resultFriendly:Int? = Int(friendly.text!)
        let resultEtc:Int? = Int(etc.text!)
        let resultLivingTax:Int? = Int(livingTax.text!)
        let resultPension:Int? = Int(pension.text!)
        let resultHealth:Int? = Int(health.text!)
        let resultIncomeTax:Int? = Int(incomeTax.text!)
        let resultEtcTax:Int? = Int(etcTax.text!)
        let resultPhone:Int? = Int(phone.text!)
        
        if resultIncome != nil && resultRent != nil && resultFood != nil && resultEnergy != nil && resultFriendly != nil && resultEtc != nil && resultLivingTax != nil && resultPension != nil && resultHealth != nil && resultIncomeTax != nil && resultEtcTax != nil && resultPhone != nil {
                let sum:Int = (resultIncome! - resultRent! - resultFood! - resultEnergy! - resultFriendly! - resultEtc! - resultLivingTax! - resultPension! - resultHealth! - resultIncomeTax! - resultEtcTax! - resultPhone!);
                let num = NSNumber(value: sum)
                let formatter = NumberFormatter()
                formatter.numberStyle = NumberFormatter.Style.decimal
                formatter.groupingSeparator = ","
                formatter.groupingSize = 3
                let result = formatter.string(from: num)
            if (sum>=0){
                total.text = "\(result!) 円黒字"
                total.textColor = UIColor.blue
            }else {
                total.text = "\(result!) 円赤字"
                total.textColor = UIColor.red
            }
        }
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        bannerView.topAnchor.constraint(equalTo: subBannerView.topAnchor, constant: 10).isActive = true
        bannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}



extension ViewController{
    
    func textFieldInit() {
        // 最初に選択されているTextFieldをセット
        self.selectedTextField = self.income
        
        // 各TextFieldのdelegate 色んなイベントが飛んでくるようになる
        self.income.delegate = self
        self.rent.delegate = self
        self.food.delegate = self
        self.energy.delegate = self
        self.phone.delegate = self
        self.friendly.delegate = self
        self.etc.delegate = self
        self.livingTax.delegate = self
        self.pension.delegate = self
        self.health.delegate = self
        self.income.delegate = self
        self.etcTax.delegate = self
        
    }
    
    // キーボードが表示された時に呼ばれる
    @objc func keyboardWillBeShown(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue, let animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue {
                restoreScrollViewSize()
                
                let convertedKeyboardFrame = scrollView.convert(keyboardFrame, from: nil)
                // 現在選択中のTextFieldの下部Y座標とキーボードの高さから、スクロール量を決定
                let offsetY: CGFloat = self.selectedTextField!.frame.maxY - convertedKeyboardFrame.minY
                if offsetY < 0 { return }
                updateScrollViewSize(moveSize: offsetY, duration: animationDuration)
            }
        }
    }
    
    // キーボードが閉じられた時に呼ばれる
    @objc func keyboardWillBeHidden(notification: NSNotification) {
        restoreScrollViewSize()
    }
    
    // TextFieldが選択された時
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // 選択されているTextFieldを更新
        self.selectedTextField = textField
    }
    
    
    // moveSize分Y方向にスクロールさせる
    func updateScrollViewSize(moveSize: CGFloat, duration: TimeInterval) {
        UIView.beginAnimations("ResizeForKeyboard", context: nil)
        UIView.setAnimationDuration(duration)
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: moveSize, right: 0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.scrollView.contentOffset = CGPoint(x: 0, y: moveSize)
        
        UIView.commitAnimations()
    }
    
    func restoreScrollViewSize() {
        // キーボードが閉じられた時に、スクロールした分を戻す
        self.scrollView.contentInset = UIEdgeInsets.zero
        self.scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
}

extension UITextField {
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        //let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))
        
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            //UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()
        self.inputAccessoryView = toolbar
    }
    
    // Default actions:
    @objc func doneButtonTapped() { self.resignFirstResponder() }
    //@objc func cancelButtonTapped() { self.resignFirstResponder() }
}

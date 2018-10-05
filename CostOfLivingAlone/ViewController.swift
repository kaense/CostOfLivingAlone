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
    
    let AdMobTest:Bool = true
    
    @IBOutlet var subBannerView: UIView!
    var bannerView: GADBannerView!
    
    @IBOutlet var total: UILabel!
    @IBOutlet var income: UITextField!
    @IBOutlet var rent: UITextField!
    @IBOutlet var food: UITextField!
    @IBOutlet var energy: UITextField!
    @IBOutlet var phone: UITextField!
    @IBOutlet var friendly: UITextField!
    @IBOutlet var etc: UITextField!
    @IBOutlet var livingTax: UITextField!
    @IBOutlet var pension: UITextField!
    @IBOutlet var health: UITextField!
    @IBOutlet var incomeTax: UITextField!
    @IBOutlet var etcTax: UITextField!
    
    // UserDefaults のインスタンス
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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



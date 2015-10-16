//
//  HomeViewController.swift
//  Wall Invest
//
//  Created by Henrique do Prado Linhares on 02/10/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var enterpriseDetailsView: UIView!
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var myWalletLabel: UILabel!
    
    @IBOutlet weak var myIncomeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "InvestmentTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "Investment")
        self.myWalletLabel.text = "Wallet: $ " + AppData.sharedInstance.player.balance.description
        self.myIncomeLabel.text = "Income: $ " + AppData.sharedInstance.player.income.description + " / day"
        self.enterpriseDetailsView.hidden = true
        self.blurView.hidden = true
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Investment") as! InvestmentTableViewCell
        
        let enterprise = AppData.sharedInstance.enterprises.enterprises[indexPath.row]
        
        cell.enterpriseName.text = enterprise.name
        cell.subtitleLabel.text = ""
        
        if ((AppData.sharedInstance.player.doesHaveHighRiskInvestmentInEnterprise(enterprise))){
            cell.subtitleLabel.text = "Value $ " + (AppData.sharedInstance.player.highRiskInvestmentForEnterprise(enterprise)?.currentValue.description)!
        }
        
        cell.enterpriseImage.image = UIImage(named: enterprise.imageName)
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "High Risk Investments"
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppData.sharedInstance.enterprises.enterprises.count
    }

    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let selectedEnterprise = AppData.sharedInstance.enterprises.enterprises[indexPath.row]
        
        let investmentNotMadeInstance = InvestmentNotMadeVC(pEnterprise: selectedEnterprise, pHomeViewController: self)

        self.presentInvestmentNotMadeViewController(investmentNotMadeInstance)
    }
    

    func presentInvestmentNotMadeViewController(pViewController:InvestmentNotMadeVC){
        self.addChildViewController(pViewController)
        self.enterpriseDetailsView.hidden = false
        self.blurView.hidden = false
        self.enterpriseDetailsView.addSubview(pViewController.view)
    }
    
    @IBAction func goalsButtonAct(sender: UIButton) {
        
        for i:HighRiskInvestment in AppData.sharedInstance.player.highRiskInvestments {
            AppData.sharedInstance.investmentManager.rescueFromHighRiskInvestment(i.enterprise)
        }
        self.viewDidLoad()
        self.tableView.reloadData()
    }

    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

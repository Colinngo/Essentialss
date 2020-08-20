//
//  CategoryVC.swift
//  Essentialss
//
//  Created by QTS Coder on 7/17/20.
//  Copyright © 2020 QTS Coder. All rights reserved.
//

import UIKit

class CategoryVC: BaseViewController {
    var categories = [categoryObj]()
    var arrSubCategories = [subCategoryObj]()
    var arrSubCategorieSearchs = [subCategoryObj]()
    @IBOutlet weak var tblCategory: UITableView!
    @IBOutlet weak var txfSearch: UITextField!
    var indexSelect = 0
    @IBOutlet weak var cltProduct: UICollectionView!
    @IBOutlet weak var bgMenuLeft: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        cltProduct.alwaysBounceVertical = true
        self.txfSearch.placeholder = "Search sub category"
        cltProduct.register(UINib.init(nibName: "ProductCollect", bundle: nil), forCellWithReuseIdentifier: "ProductCollect")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.callAPIGetAllCategory()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func doPhone(_ sender: Any) {
        self.openWhatsapp()
    }
}
extension CategoryVC
{
    func callAPIGetAllCategory()
    {
        indexSelect = 0
        CommonHelper.showBusy()
        ApiHelper.shared.getListAllCategory { (arrs) in
            self.categories.removeAll()
            if let datas = arrs
            {
                self.categories = datas
                self.tblCategory.reloadData()
            }
            if self.categories.count > 0
            {
                self.getSubCategory(self.categories[0], false)
            }
        }
    }
    
    func getSubCategory(_ categoryObj: categoryObj, _ isLoading: Bool)
    {
        if isLoading {
            CommonHelper.showBusy()
        }
        let param = NSMutableDictionary.init()
        let dict = ["id": categoryObj.id]
        param.setValue(dict, forKey: "payload")
        self.arrSubCategories.removeAll()
        ApiHelper.shared.getSubCategory(param) { (arrs) in
            self.arrSubCategories.removeAll()
            CommonHelper.hideBusy()
            if let subs = arrs
            {
                self.arrSubCategories = subs
            }
            self.arrSubCategorieSearchs = self.arrSubCategories
            self.cltProduct.reloadData()
        }
    }
}
extension CategoryVC: UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblCategory.dequeueReusableCell(withIdentifier: "CategoryCell") as! CategoryCell
        let categoryObj = self.categories[indexPath.row]
        cell.lblName.text = categoryObj.name
        if indexPath.row == indexSelect {
            cell.lblName.textColor = CommonHelper.hexStringToUIColor(hex: COLOR_APP)
            cell.bgCell.backgroundColor = UIColor.white
        }
        else{
            cell.lblName.textColor = UIColor.white
            cell.bgCell.backgroundColor = UIColor.clear
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexSelect = indexPath.row
        self.tblCategory.reloadData()
        self.getSubCategory(categories[indexPath.row], true)
    }
}
extension CategoryVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSubCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collect = self.cltProduct.dequeueReusableCell(withReuseIdentifier: "ProductCollect", for: indexPath) as! ProductCollect
        let subObj = self.arrSubCategories[indexPath.row]
        collect.configCell(subObj)
        return collect
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.cltProduct.frame.size.width - 10)/2, height: 160)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailHomeVC") as! DetailHomeVC
        vc.subCategoryObj = self.arrSubCategories[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension CategoryVC: UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.txfSearch.resignFirstResponder()
    }
}

extension CategoryVC: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         self.txfSearch.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
           let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            if  updatedText.isEmpty {
                self.arrSubCategories = self.arrSubCategorieSearchs
                self.cltProduct.reloadData()
            }
            else{
                self.arrSubCategories = self.arrSubCategorieSearchs.filter {
                    $0.name.lowercased().contains(updatedText.lowercased())
                }
                self.cltProduct.reloadData()
            }
        }
        return true
    }
}

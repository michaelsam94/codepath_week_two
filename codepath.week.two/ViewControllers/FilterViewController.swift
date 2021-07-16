//
//  FilterViewController.swift
//  codepath.week.two
//
//  Created by Michael on 16/07/2021.
//

import Foundation
import UIKit
import DropDown

class FilterViewController: UIViewController {
    
    var onFilterSelected: ((_ isOpenNow: Bool,_ selectedSortBy: String) -> Void)? = nil
    
    @IBOutlet weak var borderView: UIView!
    
    @IBOutlet weak var distanceDropDown: UIView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBAction func didPressDistance(_ sender: Any) {
        dropDown.show()
    }
    @IBOutlet weak var dropDownImageView: UIImageView!
    
    @IBOutlet weak var openNowSwitch: UISwitch!
    let dropDown = DropDown()
    let sortByDropDownData = ["Best Match","Rating","Review Count","Distance"]
    var selectedDropDownIndex = -1
    var sortByToKey: [String:String] = ["Best Match": "best_match","Rating":"rating","Distance":"distance"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Done",style: .plain, target: self, action: #selector(didDoneButtonPressed))
        
        borderView.layer.borderWidth = 1
        borderView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        borderView.layer.cornerRadius = 10
        borderView.clipsToBounds = true
        
        
        DropDown.startListeningToKeyboard()
        dropDown.anchorView = distanceDropDown
        dropDown.dataSource = sortByDropDownData
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.selectedDropDownIndex = index
            distanceLabel.text = item
        }
        distanceDropDown.layer.borderWidth = 1
        distanceDropDown.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        distanceDropDown.layer.cornerRadius = 10
        distanceDropDown.clipsToBounds = true
        dropDownImageView.setImageColor(color: UIColor.gray)
        
    }
    
    @objc func didDoneButtonPressed(){
        var selectedSortBy: String = ""
        let openNow: Bool = openNowSwitch.isOn
        if selectedDropDownIndex != -1 {
            selectedSortBy = sortByToKey[sortByDropDownData[selectedDropDownIndex]] ?? ""
        }
        onFilterSelected?(openNow,selectedSortBy)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true)
    }
}

//
//  ViewController.swift
//  ForeksTrader
//
//  Created by BarisOdabasi on 23.01.2022.
//

import UIKit
import DropDown

class ViewController: UIViewController {
    //MARK: - UI Elements
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var secondSettingsLabel: UILabel!
    @IBOutlet weak var firstSettingsLabel: UILabel!
    
    //MARK: - Properties
    var mainDataArray = [MyPageDefaults]()
    var detailArray = [L]()
    
    var timer: Timer?
    var spinner: UIActivityIndicatorView?
    var spinnerContainer: UIView?
    
    let dropDownFirst = DropDown()
    let dropDownSecond = DropDown()
    
    let settingsArray = ["Son", "%Fark", "Fark", "Düşük", "Yüksek"]
    var keyFirst = "Son"
    var keySecond = "%Fark"
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        settingsMenuConfig()
        
        tableView.delegate = self
        tableView.dataSource = self
        
  }
    //MARK: - Functions
    func updateCounting() {
        self.stopTimer()
            self.detailArray.removeAll()
            self.getDetailData(tkeArray: self.mainDataArray)
        
    }

    func getData() {
        DispatchQueue.main.async {
            self.showIndicator()
            NetworkUtils.getDefaults { res in
                self.hideIndicator()
                self.mainDataArray.append(contentsOf: res)
                self.tableView.reloadData()
                self.getDetailData(tkeArray: res)
                self.startTimer()
           }
        }
    }
    
    func getDetailData(tkeArray: [MyPageDefaults]) {
        DispatchQueue.main.async { [self] in
            for x in tkeArray {
                NetworkUtils.getDetail(tkeArray: x.tke!) { [self] result in
                    detailArray.append(contentsOf: result)
                    tableView.reloadData()
                    startTimer()
               }
            }
        }
    }
    
    //Dropdown Menu Settings And DataSource
    func settingsMenuConfig() {
        dropDownFirst.dataSource = settingsArray
        dropDownSecond.dataSource = settingsArray
        dropDownFirst.anchorView = firstSettingsLabel
        dropDownSecond.anchorView = secondSettingsLabel
        dropDownFirst.direction = .bottom
        dropDownSecond.direction = .bottom
       
        dropDownFirst.selectionAction = { [self] (index: Int, item: String) in
            firstSettingsLabel.text = item
            keyFirst = item
            tableView.reloadData()
        }
        
        dropDownSecond.selectionAction = { [self] (index: Int, item: String) in
            secondSettingsLabel.text = item
            keySecond = item
            tableView.reloadData()
        }
    }
    
    func startTimer() {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.updateCounting()
           
           })
    }
    
    func stopTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func showIndicator(){
        spinnerContainer = UIView.init(frame: self.view.frame)
        spinnerContainer!.center = self.view.center
        spinnerContainer!.backgroundColor = .init(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        self.view.addSubview(spinnerContainer!)
        
        spinner = UIActivityIndicatorView.init(style: .large)
        spinner!.center = spinnerContainer!.center
        spinner?.color = .white
        spinnerContainer!.addSubview(spinner!)
        
        spinner!.startAnimating()
    }
    
    func hideIndicator(){
        spinner?.removeFromSuperview()
        spinnerContainer?.removeFromSuperview()
    }
    
    //MARK: - Actions
    @IBAction func firstSettingButton(_ sender: UIButton) {
        dropDownFirst.show()
    }
    
    
    @IBAction func secondSettingsButton(_ sender: UIButton) {
        dropDownSecond.show()
    }
}

//MARK: - TableView Delegate And DataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewControllerCell", for: indexPath) as! ViewControllerCell
        cell.nameLabel.text = mainDataArray[indexPath.row].cod
        cell.clockLabel.text = detailArray[indexPath.row].clo
        
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "HH:mm:ss"
        let dateString = df.string(from: date)
        
        if dateString == detailArray[indexPath.row].clo {
            cell.backgroundViewCell.backgroundColor = .secondaryLabel
        } else {
            cell.backgroundViewCell.backgroundColor = .black
        }
        
        switch keyFirst {
        case "Son":
            cell.selectedLabelFirst.text = detailArray[indexPath.row].las
            cell.selectedLabelFirst.textColor = .white
        case "Fark":
            cell.selectedLabelFirst.text = detailArray[indexPath.row].pdd
            let value = detailArray[indexPath.row].pdd
           if value.uppercased().contains("-") == true {
               cell.selectedLabelFirst.textColor = .systemRed
           } else {
               cell.selectedLabelFirst.textColor = .systemGreen
               }
        case "&Fark":
            cell.selectedLabelFirst.text = "%" + detailArray[indexPath.row].ddi
            let value = detailArray[indexPath.row].ddi
           if value.uppercased().contains("-") == true {
               cell.selectedLabelSecond.textColor = .systemRed
               
           } else {
               cell.selectedLabelSecond.textColor = .systemGreen
               }
        case "Düşük":
            cell.selectedLabelFirst.text = detailArray[indexPath.row].low
            cell.selectedLabelFirst.textColor = .white
        case "Yüksek":
            cell.selectedLabelFirst.text = detailArray[indexPath.row].hig
            cell.selectedLabelFirst.textColor = .white
        default:
            break
        }
        
        switch keySecond {
        case "Son":
            cell.selectedLabelSecond.text = detailArray[indexPath.row].las
            cell.selectedLabelSecond.textColor = .white
        case "Fark":
            cell.selectedLabelSecond.text = detailArray[indexPath.row].pdd
            let value = detailArray[indexPath.row].pdd
           if value.uppercased().contains("-") == true {
               cell.selectedLabelSecond.textColor = .systemRed
               
           } else {
               cell.selectedLabelSecond.textColor = .systemGreen
               }
        case "%Fark":
            cell.selectedLabelSecond.text = "%" + detailArray[indexPath.row].ddi
            let value = detailArray[indexPath.row].ddi
           if value.uppercased().contains("-") == true {
               cell.selectedLabelSecond.textColor = .systemRed
               
           } else {
               cell.selectedLabelSecond.textColor = .systemGreen
               }
        case "Düşük":
            cell.selectedLabelSecond.text = detailArray[indexPath.row].low
            cell.selectedLabelSecond.textColor = .white
        case "Yüksek":
            cell.selectedLabelSecond.text = detailArray[indexPath.row].hig
            cell.selectedLabelSecond.textColor = .white
        default:
            break
        }
     
         let value = detailArray[indexPath.row].pdd
        if value.uppercased().contains("-") == true {
                cell.upDownImage.image = UIImage(named: "downicon")
            
        } else {
                cell.upDownImage.image = UIImage(named: "upicon")
                
            }
        
        return cell
    }
}

//
//  ListViewController.swift
//  DCM_iOS
//
//  Created by 강민석 on 2020/09/09.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa

class ListViewController: BaseViewController, StoryboardSceneBased {
    
    static let sceneStoryboard = UIStoryboard(name: "List", bundle: nil)
    
    @IBOutlet weak var topSegmented: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSegmentedControl()
        setButton()
        self.tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func configureSegmentedControl() {
        self.topSegmented.tintColor = UIColor(red: 0.02, green: 0.05, blue: 0.42, alpha: 1.00)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        guard let viewModel = self.viewModel as? ListViewModel else { fatalError("ViewModel Casting Falid!") }
        
        let refresh = self.rx.viewWillAppear.map { _ in }
        let input = ListViewModel.Input(trigger: refresh,
                                        selection: self.tableView.rx.modelSelected(ProductModel.self).asDriver(),
                                        segmented: self.topSegmented.rx.selectedSegmentIndex.asDriver(),
                                        submitButton: self.submitButton.rx.tap.asDriver())
        let output = viewModel.transform(input: input)
        
        output.items.bind(to: tableView.rx.items(cellIdentifier: "ListProductCell", cellType: ListProductCell.self)) { (index: Int, element: ProductModel, cell: ListProductCell) in
            let url = URL(string: element.imageUrl)
            cell.productImage.kf.setImage(with: url)
            cell.nameLabel.text = element.name
            
            switch element.rentAble {
            case 0:
                cell.productState.textColor = UIColor(red: 0.78, green: 0.00, blue: 0.00, alpha: 1.00)
                cell.productState.text = "대기 중"
            case 1:
                cell.productState.textColor = UIColor(red: 0.11, green: 0.54, blue: 0.00, alpha: 1.00)
                cell.productState.text = "승인 됨"
            case 2:
                cell.productState.textColor = UIColor(red: 0.89, green: 0.64, blue: 0.00, alpha: 1.00)
                cell.productState.text = "거절됨"
            default:
                cell.productState.text = "Error!"
            }
        }.disposed(by: disposeBag)
    }
    
    func setButton() {
        self.topSegmented.rx.selectedSegmentIndex
            .subscribe(onNext: { index in
                if index == 0 {
                    self.submitButton.isHidden = true
                } else {
                    self.submitButton.isHidden = false
                }
            }).disposed(by: disposeBag)
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

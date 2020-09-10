//
//  ListViewModel.swift
//  DCM_iOS
//
//  Created by 강민석 on 2020/09/09.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import RxSwift
import RxCocoa
import FirebaseFirestore

class ListViewModel: BaseViewModel {
    
    struct Input {
        let trigger: Observable<Void>
        let selection: Driver<ProductModel>
        let segmented: Driver<Int>
        let submitButton: Driver<Void>
    }
    
    struct Output {
        let items: BehaviorRelay<[ProductModel]>
    }
    
    let elements = BehaviorRelay<[ProductModel]>(value: [])
    
    func transform(input: Input) -> Output {
        
        input.trigger
            .subscribe(onNext: { [weak self] in
                self?.productRequest(index: 0)
            }).disposed(by: disposeBag)
        
        input.selection
            .drive(onNext: { item in
                self.steps.accept(DCMStep.productIsRequired(product: item))
            }).disposed(by: disposeBag)
        
        input.segmented
            .drive(onNext: { [weak self] index in
                self?.productRequest(index: index)
            }).disposed(by: disposeBag)
        
        input.submitButton
            .drive(onNext: { [weak self] in
                self?.steps.accept(DCMStep.submitIsRequired)
            }).disposed(by: disposeBag)
        
        return Output(items: elements)
    }
    
    func productRequest(index: Int) {
        let db = Firestore.firestore()
        
        self.loading.accept(true)
        
        if index == 0 {
            let productRef = db.collection("product")
                .whereField("rentUser", isEqualTo: KeychainManager.getToken())
                .addSnapshotListener { (querySnapShot, error) in
                    guard let documents = querySnapShot?.documents else {
                        print("No documents")
                        return
                    }
                    
                    let product = documents.compactMap { (queryDocumentSnapshot) -> ProductModel? in
                        let data = queryDocumentSnapshot.data()
                        
                        let name = data["name"] as? String ?? ""
                        let imageUrl = data["imageUrl"] as? String ?? ""
                        let content = data["content"] as? String ?? ""
                        let rentAble = data["rentAble"] as? Int ?? 0
                        let rentUser = data["rentUser"] as? String ?? ""
                        let createAt = data["createAt"] as? String ?? ""
                        
                        return ProductModel(name: name,
                                            imageUrl: imageUrl,
                                            content: content,
                                            rentAble: rentAble,
                                            rentUser: rentUser,
                                            createAt: createAt)
                    }
                    self.loading.accept(false)
                    self.elements.accept(product)
            }
        } else {
            let productRef = db.collection("submit")
                .whereField("submitUser", isEqualTo: KeychainManager.getToken())
                .addSnapshotListener { (querySnapShot, error) in
                    guard let documents = querySnapShot?.documents else {
                        print("No documents")
                        return
                    }
                    
                    let product = documents.compactMap { (queryDocumentSnapshot) -> ProductModel? in
                        let data = queryDocumentSnapshot.data()
                        
                        let name = data["name"] as? String ?? ""
                        let imageUrl = data["imageUrl"] as? String ?? ""
                        let content = data["content"] as? String ?? ""
                        let rentAble = data["submitAble"] as? Int ?? 0
                        let rentUser = data["submitUser"] as? String ?? ""
                        let createAt = data["createAt"] as? String ?? ""
                        
                        return ProductModel(name: name,
                                            imageUrl: imageUrl,
                                            content: content,
                                            rentAble: rentAble,
                                            rentUser: rentUser,
                                            createAt: createAt)
                    }
                    self.loading.accept(false)
                    self.elements.accept(product)
            }
        }
    }
}

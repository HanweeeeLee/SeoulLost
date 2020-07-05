//
//  LostItemTabView.swift
//  SeoulLost
//
//  Created by hanwe lee on 2020/06/11.
//  Copyright © 2020 hanwe. All rights reserved.
//

import SwiftUI

struct LostItemTabView: View {
    @State var presentingModal = false
    @ObservedObject var viewModel: LostItemTabViewModel
    
    @State var lostPlacePickerSelectionIndex:Int = 0
    @State var lostArticlePickerSelectionIndex:Int = 0

    @State var lostPlaceTypeKoreanArr:Array = LostPlaceType.allEnumKoreanArray()
    @State var lostArticleTypeKoreanArr:Array = LostArticleType.allEnumKoreanArray()
    
    var body: some View {
        NavigationView {
            VStack {
                content
                Button("Present") { self.presentingModal = true }
                .sheet(isPresented: $presentingModal) { LostItemLocationPickerView(presentedAsModal: self.$presentingModal) }
            }
        }
        .onAppear {
            print("LostItemTabView onAppear")
            for value in LostPlaceType.allCases {
                print(value)
            }
            LostArticleType.allEnumKoreanArray()
        }
        .onDisappear() {
            print("LostItemTabView onDisappear")
        }
    }
    
    private var content: some View {
        return LoadingView(isShowing: self.$viewModel.isShowLoading) {
            ZStack {
//                Color.purple.edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
//                        TextFieldWithPickerAsInputView(data: self.lostPlaceTypeKoreanArr, placeholder: "분실 장소", selectionIndex: self.$lostPlacePickerSelectionIndex, text: self.$viewModel.placeTxt)
//                        TextFieldWithPickerAsInputView(data: self.lostArticleTypeKoreanArr, placeholder: "분실 물건 타입", selectionIndex: self.$lostArticlePickerSelectionIndex, text: self.$viewModel.lostArticleTypeTxt)
                        Text("hi")
                    }
                    Spacer()
                    Text("test")
                                            Spacer()
                                            Text("test2")
                }
                
            }
        }
    }
    
    public func viewDidLoad() -> LostItemTabView  {
        return self
    }
    
//    @objc func doneTapped() {
////        self.toolbarDelegate?.didTapDone()
//        print("test")
//    }
}

struct TextFieldWithPickerAsInputView : UIViewRepresentable {
    
    var data : [String]
    var placeholder : String
//    var selector:Selector
    
    @Binding var selectionIndex : Int
    @Binding var text : String
    
    private let textField = UITextField()
    private let picker = UIPickerView()
    
    func makeCoordinator() -> TextFieldWithPickerAsInputView.Coordinator {
        Coordinator(textfield: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<TextFieldWithPickerAsInputView>) -> UITextField {
        picker.delegate = context.coordinator
        picker.dataSource = context.coordinator
        picker.backgroundColor = .white
        picker.tintColor = .black
        textField.placeholder = placeholder
        textField.inputView = picker
        textField.delegate = context.coordinator
        
//        let toolBar = UIToolbar()
//        toolBar.barStyle = UIBarStyle.default
//        toolBar.isTranslucent = true
//        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
//        toolBar.sizeToFit()
//
//        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: nil)
////        let doneButton = UIBarButtonItem(title: <#T##String?#>, style: <#T##UIBarButtonItem.Style#>, target: <#T##Any?#>, action: <#T##Selector?#>)
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//
//        toolBar.setItems([spaceButton, doneButton], animated: false)
//        toolBar.isUserInteractionEnabled = true
//
////        textField.inputView = picker
//        textField.inputAccessoryView = toolBar
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<TextFieldWithPickerAsInputView>) {
        uiView.text = text
    }
    
    class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate , UITextFieldDelegate {
        
        private let parent : TextFieldWithPickerAsInputView
        
        init(textfield : TextFieldWithPickerAsInputView) {
            self.parent = textfield
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return self.parent.data.count
        }
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return self.parent.data[row]
        }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            self.parent.$selectionIndex.wrappedValue = row
            self.parent.text = self.parent.data[self.parent.selectionIndex]
            self.parent.textField.endEditing(true) //기존 UIKit처럼 done버튼같은 toolbar를 붙혀서 하고싶지만 쉽지는 않을것같아서 임시로 이렇게 진행
        }
        func textFieldDidEndEditing(_ textField: UITextField) {
            self.parent.textField.resignFirstResponder()
        }
    }
}

struct LostItemTabView_Previews: PreviewProvider { //화면 테스트정도의 의미
        static var previews: some View {
            Group {
                LostItemTabView(viewModel: LostItemTabViewModel())
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
                    .previewDisplayName("iPhone SE")
                    .environment(\.colorScheme, .dark)
                
                LostItemTabView(viewModel: LostItemTabViewModel())
                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
                    .previewDisplayName("iPhone 11")
            }
        }
}

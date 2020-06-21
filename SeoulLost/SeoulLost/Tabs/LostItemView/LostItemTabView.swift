//
//  LostItemTabView.swift
//  SeoulLost
//
//  Created by hanwe lee on 2020/06/11.
//  Copyright © 2020 hanwe. All rights reserved.
//

import SwiftUI

struct LostItemTabView: View {
    @ObservedObject var viewModel: LostItemTabViewModel
    
    @State var gender : String? = nil
    @State var arrGenders = ["Male","Female","Unknown"]
    @State var selectionIndex = 0
    
    var body: some View {
        NavigationView {
            VStack {
                content
            }
        }
        .onAppear {
            print("LostItemTabView onAppear")
        }
        .onDisappear() {
            print("LostItemTabView onDisappear")
        }
    }
    
    private var content: some View {
        return LoadingView(isShowing: self.$viewModel.isShowLoading) {
            VStack {
//                Text("\(self.viewModel.placeTxt)")
//                Text("\(self.viewModel.lostArticleTypeTxt)")
//                TextField("잃어버린 장소", text: self.$viewModel.placeTxt)
                TextFieldWithPickerAsInputView(data: self.arrGenders, placeholder: "잃어버린 장소", selector: #selector(self.doneTapped), selectionIndex: self.$selectionIndex, text: self.$gender)
                
            }
        }
    }
    
    public func viewDidLoad() -> LostItemTabView  {
        return self
    }
    
    @objc func doneTapped() {
//        self.toolbarDelegate?.didTapDone()
        print("test")
    }
}

struct TextFieldWithPickerAsInputView : UIViewRepresentable {
    
    var data : [String]
    var placeholder : String
    var selector:Selector
    
    @Binding var selectionIndex : Int
    @Binding var text : String?
    
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
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: selector)
//        let doneButton = UIBarButtonItem(title: <#T##String?#>, style: <#T##UIBarButtonItem.Style#>, target: <#T##Any?#>, action: <#T##Selector?#>)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)

        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

//        textField.inputView = picker
        textField.inputAccessoryView = toolBar
        
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
            //               self.parent.textField.endEditing(true)
        }
        func textFieldDidEndEditing(_ textField: UITextField) {
            self.parent.textField.resignFirstResponder()
        }
    }
}

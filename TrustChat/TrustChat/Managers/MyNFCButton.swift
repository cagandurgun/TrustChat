//
//  MyNFCButton.swift
//  TrustChat
//
//  Created by Çağan Durgun on 31.05.2024.
//

///  Tutorial: https://youtu.be/5PtGsRK_uIs?si=kRfsX6WPvM_oj1FF

import SwiftUI
import CoreNFC

/**
 Bu dosya içerisinde nfc işlemleri yapılacaktır. Bu dosya _@StartChatView ile birlikte çalışacaktır.
 */
struct MyNFCButton: UIViewRepresentable {
    /// this data is the data that we recive form NFC's
    @Binding var data: String
    
    func makeUIView(context: UIViewRepresentableContext<MyNFCButton>) -> UIButton {
        let button = UIButton()
        button.setTitle("Read NFC", for: .normal)
        button.backgroundColor = UIColor.blue
        button.addTarget(context.coordinator, action: #selector(context.coordinator.beginScan(_:)), for: .touchUpInside)
        return button
    }
    
    func updateUIView(_ uiView: UIButton, context: UIViewRepresentableContext<MyNFCButton>) {
        ///
    }
    
    func makeCoordinator() -> MyNFCButton.Coordinator {
        return Coordinator(data: $data)
    }
    
    class Coordinator: NSObject, NFCNDEFReaderSessionDelegate {
        var session: NFCNDEFReaderSession?
        
        /// this data is the data that we recive form NFC's
        /// and should match with the top
        @Binding var data: String
        
        init(data: Binding<String>) {
            _data = data
        }
        
        @objc func beginScan(_ sender: Any) {
            guard NFCNDEFReaderSession.readingAvailable
            else {
                print("error: Scanning not support")
                return
            }
            
            session = NFCNDEFReaderSession(delegate: self, queue: .main, invalidateAfterFirstRead: true)
            session?.alertMessage = "Hold your iPhone near to scan."
            session?.begin()
        }
        
        func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: any Error) {
            if let readerError = error as? NFCReaderError {
                if (readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead)
                    && (readerError.code != .readerSessionInvalidationErrorUserCanceled) {
                    print("error nfc read: \(readerError.localizedDescription)")
                }
            }
            self.session = nil
        }
        
        func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
            guard
                let nfcMessage = messages.first,
                let record = nfcMessage.records.first,
                record.typeNameFormat == .absoluteURI || record.typeNameFormat == .nfcWellKnown,
                let payload = String(data: record.payload, encoding: .utf8)
            else {
                return
            }
            
            print(payload)
            self.data = payload
        }
        
        /// this is for nfc write
        /**
         func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [any NFCNDEFTag]) {
             <#code#>
         }
         */
    } /// end of the Coordinator class
} /// end of the MyNFCButton struct

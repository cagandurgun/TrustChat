//
//  MessagesView.swift
//  TrustChat
//
//  Created by Çağan Durgun on 2.08.2024.
//

import SwiftUI

/// burası daha generic olmalıdır. kimle konuşuluyorsa onun parametresi geçecek. her şey ona göre yapılacak.
///
struct MessagesView: View {
    
    @EnvironmentObject var userModel: UserModel
    @State private var timer: DispatchSourceTimer?
    @State private var receivedMessages: [MessageModel] = []
    @State private var messageText: String = ""
    let addressee: AddresseeModel
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading) {
                    ForEach(receivedMessages, id: \.date) { message in
                        HStack {
                            if message.messageSender == userModel.email {
                                Spacer()
                            }
                            
                            MessageRowView(message: message)
                                .environmentObject(userModel)
                            
                            if message.messageSender != userModel.email {
                                Spacer()
                            }
                        }
                    }
                }
                .padding()
            }
            .scrollDismissesKeyboard(.interactively)
            
            VStack {
                Spacer()
                
                HStack {
                    TextField("", text: $messageText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    if !messageText.trimmingCharacters(in: .whitespaces).isEmpty {
                        Button(action: {
                            sendMessage()
                            messageText = ""
                        }) {
                            Text("Send")
                        }
                    }
                }
                .ignoresSafeArea()
                .padding(10)
                .background(Color.secondary.opacity(0.35))
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(addressee.name)
        .onAppear(perform: startTimer)
        .onDisappear(perform: stopTimer)
    }
    
    
    ///
    func sendNotification() {
        /// if previous receivedMessages != recent receivedMessages then send notification
        ///
        /// bu ekranda bile değilse yine de bildirim gelmeli.
    }
    
    /// for fetching messagges
    func startTimer() {
        let queue = DispatchQueue(label: "com.cagandurgun.trustchat.timer", attributes: .concurrent)
        let newTimer = DispatchSource.makeTimerSource(queue: queue)
        newTimer.schedule(deadline: .now(), repeating: .milliseconds(1000)) // Adjust the repeating interval as needed
        newTimer.setEventHandler { [weak timer = newTimer] in
            print("timer started: \(timer!)")/// warningden kurtulmak için.
            DispatchQueue.main.async {
                self.fetchMessages()
            }
        }
        
        newTimer.resume()
        
        DispatchQueue.main.async {
            self.timer = newTimer
        }
    }
    
    /// for fetching messagges
    func stopTimer() {
        DispatchQueue.main.async {
            self.timer?.cancel()
            self.timer = nil
        }
    }
    
    /// for fetching messagges
    // buradaki userModel.karsi_taraf yerine receiver gelebilir.
    /// burada kullanıcıların isimleri _ ile bağlandığı için bu parametrelerde _ kullanılmasını yasaklamalıyız. Çok Önemli
    func fetchMessages() {
        let combinedUsernames = "\(userModel.email)_\(addressee.email)"
        guard let url = URL(string: "https://cagandurgun.pythonanywhere.com/get_messages/\(combinedUsernames)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            if let decodedMessages = try? JSONDecoder().decode([MessageModel].self, from: data) {
                DispatchQueue.main.async {
                    /// burada += kullanıldığı durum -> API'ın tüm mesajları tutmadığı durumdur
                    receivedMessages = decodedMessages
                }
            }
        }.resume()
    }
    
    /// for sending messagges
    // buradaki userModel.karsi_taraf yerine receiver gelebilir.
    func sendMessage() {
        guard let url = URL(string: "https://cagandurgun.pythonanywhere.com/send_message") else { return }
        
        /// burada gerekli bilgiler yazılır. 
        let message = MessageModel(messageSender: userModel.email, messageGetter: addressee.email, message: messageText, date: Date())
        print(message.date)/// for debug
        guard let encodedMessage = try? JSONEncoder().encode(message) else { return }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = encodedMessage
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            //print("neler oluyor")
            if let decodedMessage = try? JSONDecoder().decode(MessageModel.self, from: data) {
                print("Mesaj gönderildi: \(decodedMessage)")
            }
        }.resume()
    }
}


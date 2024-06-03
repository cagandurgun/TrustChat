//
//  CopyrightView.swift
//  TrustChat
//
//  Created by Çağan Durgun on 30.05.2024.
//

import SwiftUI

struct CopyrightView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("© 2024 TrustChat™. Tüm hakları saklıdır.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Spacer()
                
            }
            HStack {
                Spacer()
                Text("Bu uygulama ve içeriği, TrustChat™'nın")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Spacer()
            }
            HStack {
                Spacer()
                Text("mülkiyetindedir ve telif hakkı yasalarıyla")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Spacer()
            }
            HStack {
                Spacer()
                Text("korunmaktadır. İzinsiz kopyalanamaz, ")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Spacer()
            }
            HStack {
                Spacer()
                Text("dağıtılamaz veya çoğaltılamaz.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Spacer()
            }
        }
    }
}

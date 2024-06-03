# TrustChat
Real time messaging app
# MVP Message App

Bu proje, Swift ile geliştirilmiş basit bir mesajlaşma uygulamasıdır. Aynı zamanda, uygulamanın ihtiyaç duyduğu verileri sağlamak için bir API de geliştirilmiştir.

## İçindekiler

- [Özellikler](#özellikler)
- [Kurulum](#kurulum)
- [Kullanım](#kullanım)
- [API](#api)
- [Katkıda Bulunma](#katkıda-bulunma)
- [Lisans](#lisans)

## Özellikler

- Kullanıcı kaydı ve oturum açma
- Mesaj gönderme ve alma
- Gerçek zamanlı mesajlaşma (WebSocket ile)
- Kullanıcılar arasında mesaj geçmişini görüntüleme

## Kurulum

### Gereksinimler

- iOS 13.0 veya üstü
- Xcode 12.0 veya üstü
- Swift 5.0 veya üstü

### Adımlar

1. Bu repoyu klonlayın:

    ```bash
    git clone https://github.com/kullaniciadi/mvp-message-app.git
    cd mvp-message-app
    ```

2. Xcode'da proje dosyasını açın:

    ```bash
    open MVPMessageApp.xcodeproj
    ```

3. Bağımlılıkları yükleyin (Eğer kullanıyorsanız, CocoaPods veya Swift Package Manager):

    ```bash
    pod install
    ```

4. API servislerini başlatın. API klasörüne gidin ve gerekli bağımlılıkları yükleyin:

    ```bash
    cd API
    npm install
    npm start
    ```

5. Uygulamayı çalıştırın:

    Xcode'da hedef cihazı seçin ve çalıştırın (Cmd + R).

## Kullanım

- Uygulama açıldığında, yeni bir hesap oluşturabilir veya mevcut bir hesapla oturum açabilirsiniz.
- Oturum açtıktan sonra, diğer kullanıcılarla mesajlaşabilirsiniz.
- Mesajlar gerçek zamanlı olarak güncellenir.

## API

API, mesajlaşma uygulamanızın sunucu tarafını oluşturur. Aşağıda bazı temel API uç noktaları bulunmaktadır:

- `POST /register`: Kullanıcı kaydı
- `POST /login`: Kullanıcı girişi
- `GET /messages`: Mesaj geçmişini al
- `POST /messages`: Yeni mesaj gönder

API hakkında daha fazla bilgi için `API` klasöründeki README.md dosyasına göz atabilirsiniz.

## Katkıda Bulunma

Katkılarınızı bekliyoruz! Lütfen katkıda bulunmadan önce bir issue açarak bize ulaşın.

1. Fork yapın.
2. Yeni bir dal (branch) oluşturun: `git checkout -b yeni-ozellik`
3. Değişikliklerinizi commit yapın: `git commit -am 'Yeni özellik ekle'`
4. Dalınıza push yapın: `git push origin yeni-ozellik`
5. Bir Pull Request açın.

## Lisans

Bu proje MIT lisansı ile lisanslanmıştır. Daha fazla bilgi için LICENSE dosyasına göz atın.

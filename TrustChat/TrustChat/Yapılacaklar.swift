///
/// __ÇOK ÖNEMLİ__
/// MessagesViewdaki fetch fonksiyonunda
/// burada kullanıcıların isimleri _ ile bağlandığı için bu parametrelerde _ kullanılmasını yasaklamalıyız. Çok Önemli
///
/// __API optimizasyonu__
/// API'da tüm kullanıcıların tüm mesajları tutulmaktadır.
/// bunu, yalnızca alınmamış mesajlar olarak değiştirebilir miyiz?
/// mesajlar apiden çekilirken çok fazla api ziyareti yapılmakta bunu düzeltelim. (bu swift tarafında halledilecek gibi)
/// tüm mesajlar API de tutuluyor. aslında API yalnızca bir iletim merkezi olarak kurgulanırsa daha verimli olacaktır.
///  kullanıcı bir mesajı apıden aldığında otomatik olarak firestoreda ayrılmış bir alana kaydeder.
///  uygulama açıldığında da yeniden buradan çekilir.
///  bu sayede API yorulmamış olur. ve fazla veri çekmeye gerek kalmaz
///
/// __Uygulama Mimarisi düzenlemeleri__
/// fonksiyonlar düzenlenmelidir.
///
/// __Chat__
/// mesajlaşma herkesin arasında olabilmeli?
/// buu nasıl seçilmeli istek mi atılmalı?
/// mesaj ekranı düzenlenmeli
/// konuşma ekranına günler eklensin.
/// Chatelere silme gesture ekleyelim. silince databaseden de silinsin
///
///
///
/// __Notifications__
/// arka planda mesajları isteriz apiden.
/// eğer yeni bir mesaj geldi ise (eski mesajlarla yeniler karşılaştırılır? bir şekilde güzel bir çözüm bul) bildirimi gönderilir. Bu konu API ile de bağlantılı.
///
///
///
/// network requestler bir managerda toplanmalıdır.

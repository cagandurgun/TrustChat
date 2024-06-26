### API support has been discontinued.
##  https://www.youtube.com/watch?v=z6q9kug0PL0 
#   trust chat api

from flask import Flask, request, jsonify
import uuid

app = Flask(__name__)

class Message:
    def __init__(self, messageSender, messageGetter, message, date):
        self.message_id = str(uuid.uuid4())  # Benzersiz kimlik
        self.messageSender = messageSender
        self.messageGetter = messageGetter
        self.message = message
        self.date = date

class Messages:
    def __init__(self):
        self.messages = []

    def add_message(self, obj):
        self.messages.append(obj)

    def get_messages_for_users(self, user1, user2):
        # İki kullanıcı arasındaki mesajları filtrele
        filtered_messages = [msg for msg in self.messages if (msg.messageSender == user1 and msg.messageGetter == user2) or (msg.messageSender == user2 and msg.messageGetter == user1)]
        # Mesajları tarihe göre sırala
        filtered_messages.sort(key=lambda x: x.date)
        return filtered_messages

messages = Messages()

@app.route('/send_message', methods=['POST'])
def send_message():
    messageSender = request.json.get('messageSender')
    messageGetter = request.json.get('messageGetter')
    message = request.json.get('message')
    date = request.json.get('date') # Swift tarafından gönderilen date değerini alın
    new_message = Message(messageSender, messageGetter, message, date)
    messages.add_message(new_message)
    return jsonify({"message": "Mesaj gönderildi"}), 200

@app.route('/get_messages/<messageGetter>', methods=['GET'])
def get_messages(messageGetter):
    # messageGetter parametresini kullanıcı adlarına ayır
    user1, user2 = messageGetter.split('_')

    # İki kullanıcı arasındaki mesajları al
    all_messages = messages.get_messages_for_users(user1, user2)

    # Tüm mesajları JSON formatına dönüştür ve dönüş yap
    return jsonify([vars(msg) for msg in all_messages]), 200

# Web site end point
@app.route('/TrustChat')
def index():
    return index_html


# Web Site
index_html = """
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TrustChat™ - Hoş Geldiniz</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            background-color: black; /* Arka plan rengi */
            overflow: hidden;
        }
        #animation-container {
            width: 100%;
            height: 100%;
            position: absolute;
            top: 0;
            left: 0;
            z-index: -1;
        }
    </style>
</head>
<body>
    <div id="animation-container"></div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
    <script>
        // Basic setup
        const scene = new THREE.Scene();
        const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
        const renderer = new THREE.WebGLRenderer();
        renderer.setSize(window.innerWidth, window.innerHeight);
        document.body.appendChild(renderer.domElement);

        // Create 3D text
        const loader = new THREE.FontLoader();
        loader.load('https://threejs.org/examples/fonts/helvetiker_regular.typeface.json', function (font) {
            const textGeometry = new THREE.TextGeometry('TrustChat™', {
                font: font,
                size: 0.5,
                height: 0.1,
                curveSegments: 12,
                bevelEnabled: true,
                bevelThickness: 0.03,
                bevelSize: 0.02,
                bevelSegments: 5
            });

            textGeometry.computeBoundingBox();
            const textWidth = textGeometry.boundingBox.max.x - textGeometry.boundingBox.min.x;
            textGeometry.translate(-0.5 * textWidth, 0, 0);

            const material = new THREE.MeshPhongMaterial({ color: 0x00ff00, flatShading: true }); // Yeşil renk
            const mesh = new THREE.Mesh(textGeometry, material);
            scene.add(mesh);

            // Hızlı dönme hızları
            const rotationSpeedX = Math.random() * 0.03 - 0.015;
            const rotationSpeedY = Math.random() * 0.03 - 0.015;
            const rotationSpeedZ = Math.random() * 0.03 - 0.015;

            function animateText() {
                mesh.rotation.x += rotationSpeedX;
                mesh.rotation.y += rotationSpeedY;
                mesh.rotation.z += rotationSpeedZ;
            }

            function animate() {
                requestAnimationFrame(animate);

                animateText();

                renderer.render(scene, camera);
            }

            animate();
        });

        camera.position.z = 5;

        // Add lighting
        const ambientLight = new THREE.AmbientLight(0xffffff, 0.5);
        scene.add(ambientLight);
        const pointLight = new THREE.PointLight(0xffffff, 1);
        pointLight.position.set(5, 5, 5);
        scene.add(pointLight);

        // Responsive resize
        window.addEventListener('resize', () => {
            const width = window.innerWidth;
            const height = window.innerHeight;
            renderer.setSize(width, height);
            camera.aspect = width / height;
            camera.updateProjectionMatrix();
        });
    </script>
</body>
</html>
"""

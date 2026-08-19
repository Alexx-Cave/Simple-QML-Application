import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls

Window {
    id: window
    width: 450
    height: 350
    visible: true
    title: "Главный экран"

    // Свойство для хранения созданных окон
    property var createdWindows: []

    // Основной контейнер
    Rectangle {
        anchors.fill: parent

        // Градиентный фон
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#667eea" }
            GradientStop { position: 1.0; color: "#764ba2" }
        }

        // Заголовок
        Text {
            id: titleText
            anchors {
                top: parent.top
                topMargin: 30
                horizontalCenter: parent.horizontalCenter
            }
            text: "🌟 Добро пожаловать! 🌟"
            color: "white"
            font {
                pixelSize: 28
                bold: true
                family: "Arial"
            }
            style: Text.Raised
            styleColor: "#80000000"
        }

        // Кастомная кнопка
        Item {
            id: customButton
            width: 220
            height: 70
            anchors.centerIn: parent

            // Фон кнопки
            Rectangle {
                id: buttonBackground
                anchors.fill: parent
                radius: 35

                // Градиент для фона
                gradient: Gradient {
                    GradientStop {
                        position: 0.0
                        color: mouseArea.containsMouse ? "#48c6ef" : "#6a11cb"
                    }
                    GradientStop {
                        position: 1.0
                        color: mouseArea.containsMouse ? "#6a11cb" : "#2575fc"
                    }
                }

                // Тень
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: -5
                    radius: parent.radius + 2
                    color: "transparent"
                    border.width: 3
                    border.color: mouseArea.containsMouse ? "#60ffffff" : "#40ffffff"
                    z: -1
                }
            }

            // Текст кнопки
            Text {
                anchors.centerIn: parent
                text: mouseArea.containsMouse ? "✨ Создать окно ✨" : "Создать новое окно"
                color: "white"
                font {
                    pixelSize: mouseArea.containsMouse ? 20 : 18
                    bold: true
                }
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            // Область мыши
            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    createNewWindow()
                    messagePopup.visible = true
                    messageText.text = "🎉 Новое окно создано! 🎉"
                }

                onEntered: {
                    pulseAnimation.start()
                }

                onExited: {
                    pulseAnimation.stop()
                    customButton.scale = 1.0
                }
            }

            // Анимация пульсации
            SequentialAnimation {
                id: pulseAnimation
                loops: Animation.Infinite

                NumberAnimation {
                    target: customButton
                    property: "scale"
                    to: 1.1
                    duration: 600
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    target: customButton
                    property: "scale"
                    to: 1.0
                    duration: 600
                    easing.type: Easing.InOutQuad
                }
            }
        }// Всплывающее сообщение
        Rectangle {
            id: messagePopup
            width: 200
            height: 50
            radius: 25
            color: "#00b09b"
            anchors {
                top: customButton.bottom
                topMargin: 30
                horizontalCenter: parent.horizontalCenter
            }
            visible: false

            Text {
                id: messageText
                anchors.centerIn: parent
                color: "white"
                font {
                    pixelSize: 18
                    bold: true
                }
            }

            // Анимация появления
            PropertyAnimation {
                id: showAnimation
                target: messagePopup
                property: "scale"
                from: 0
                to: 1
                duration: 300
                easing.type: Easing.OutBack
            }

            // Таймер для скрытия
            Timer {
                interval: 2000
                running: messagePopup.visible
                onTriggered: {
                    messagePopup.visible = false
                }
            }

            onVisibleChanged: {
                if (visible) showAnimation.start()
            }
        }

        // Кнопка закрытия главного окна
        Rectangle {
            id: closeButton
            width: 35
            height: 35
            radius: 17.5
            color: closeMouseArea.containsMouse ? "#ff4757" : "#ff6b6b"
            anchors {
                top: parent.top
                right: parent.right
                margins: 15
            }

            Text {
                anchors.centerIn: parent
                text: "✕"
                color: "white"
                font {
                    bold: true
                    pixelSize: 20
                }
            }

            MouseArea {
                id: closeMouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: Qt.quit()
            }

            Behavior on scale {
                NumberAnimation { duration: 150 }
            }
            Behavior on color {
                ColorAnimation { duration: 150 }
            }

            states: [
                State {
                    name: "hovered"
                    when: closeMouseArea.containsMouse
                    PropertyChanges {
                        target: closeButton
                        scale: 1.2
                    }
                }
            ]

            transitions: Transition {
                NumberAnimation { property: "scale"; duration: 150 }
            }
        }

        // Плавающие точки
        Repeater {
            model: 6
            Rectangle {
                x: Math.random() * parent.width
                y: Math.random() * parent.height
                width: size
                height: size
                radius: size / 2
                color: "white"
                opacity: 0.2

                property int size: 4 + Math.random() * 6

                SequentialAnimation on y {
                    loops: Animation.Infinite
                    NumberAnimation {
                        to: parent.height - 50
                        duration: 4000 + Math.random() * 3000
                        easing.type: Easing.InOutQuad
                    }
                    NumberAnimation {
                        to: 50
                        duration: 4000 + Math.random() * 3000
                        easing.type: Easing.InOutQuad
                    }
                }

                SequentialAnimation on opacity {
                    loops: Animation.Infinite
                    NumberAnimation { to: 0.5; duration: 2000 }
                    NumberAnimation { to: 0.1; duration: 2000 }
                }
            }
        }
    }// Функция для создания нового окна
    function createNewWindow() {
        var component = Qt.createComponent("222.qml")
        if (component.status === Component.Ready) {
            var newWindow = component.createObject(window)
            newWindow.show()
            // Сохраняем ссылку на окно
            createdWindows.push(newWindow)

            // Подключаем сигнал закрытия для удаления из массива
            newWindow.closing.connect(function() {
                var index = createdWindows.indexOf(newWindow)
                if (index !== -1) {
                    createdWindows.splice(index, 1)
                }
            })
        } else {
            console.log("Ошибка загрузки компонента:", component.errorString())
        }
    }
}

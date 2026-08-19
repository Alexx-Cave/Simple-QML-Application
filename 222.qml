import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    id:emp
    width: 300
    height: 200
    visible: false  // По умолчанию невидимо, покажем через show()
    title: "Подокно"

    // Градиентный фон
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#43e97b" }
            GradientStop { position: 1.0; color: "#38f9d7" }
        }

        // Текст по центру
        Text {
            anchors.centerIn: parent
            text: "✨ Пустое окно ✨"
            color: "white"
            font {
                pixelSize: 20
                bold: true
            }
            style: Text.Raised
            styleColor: "#80000000"
        }

        // Кнопка закрытия этого окна
        Rectangle {
            id: closeButton
            width: 30
            height: 30
            radius: 15
            color: closeMouseArea.containsMouse ? "#ff4757" : "#ff6b6b"
            anchors {
                top: parent.top
                right: parent.right
                margins: 10
            }

            Text {
                anchors.centerIn: parent
                text: "✕"
                color: "white"
                font.bold: true
            }

            MouseArea {
                id: closeMouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: emp.close()
            }
        }
    }
}

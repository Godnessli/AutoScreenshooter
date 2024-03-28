import QtCore
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtWebEngine
import QtQuick.Dialogs
import QtQuick.Controls.Imagine
import com.mycompany.qmlcomponents

ApplicationWindow {
    width: 1280
    height: 900

    title: qsTr("Карта АСУ")

    Rectangle {
        id: maps1
        objectName: "maps"
        anchors {
            left: parent.left
            leftMargin: 245
            top: parent.top
            right: parent.right
            bottom: parent.bottom
        }
        states: [
            State {
                name: "open"

                PropertyChanges {
                    target: tab
                    source: "TableBuild.qml"
                }

                PropertyChanges {
                    target: maps1
                    anchors.bottomMargin: 245
                }

                PropertyChanges {
                    target: filebtn
                    text: "Закрыть таблицу"
                    onClicked: maps1.state = "close"
                }
            },

            State {
                name: "close"

                PropertyChanges {
                    target: tab
                    source: ""
                }

                PropertyChanges {
                    target: maps1
                    anchors.bottomMargin: 0
                }

                PropertyChanges {
                    target: filebtn
                    text: "Загрузить файл Excel"
                    onClicked: maps1.state = "open"
                }
            }
        ]

        transitions: Transition {
                PropertyAnimation { properties: "bottomMargin"; easing.type: Easing.OutQuad }
            }
    }

    Loader {
        id: tab
        anchors {
            left: instruments.right
            leftMargin: 5
            top: maps1.bottom
            topMargin: 5
            right: parent.right
            bottom: parent.bottom
        }
    }

    Rectangle{
        id: instruments
        color: "#efefef"
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
            right: maps1.left
            rightMargin: 5
        }

        Button {
            id: filebtn
            anchors.horizontalCenter: instruments.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 40
            width: 180
            height: 60
            text: "Загрузить файл Excel"
            onClicked: maps1.state = "open"
        }

        Button {
            id: screenbtn
            anchors {
                horizontalCenter: instruments.horizontalCenter
                top: parent.top
                topMargin: 40
            }
            width: 180
            height: 60
            text: qsTr("Скриншот")
            onClicked: web.grabToImage(function(result) {result.saveToFile();});
        }
    }

    Rectangle {
        id: edge1
        anchors {
            left: instruments.right
            top: parent.top
            bottom: parent.bottom
            right: maps1.left
        }
        color: "#696969"
    }

    Rectangle {
        id: edge2

        anchors {
            left: instruments.right
            top: maps1.bottom
            bottom: tab.top
            right: parent.right
        }
        color: "#696969"
    }
}

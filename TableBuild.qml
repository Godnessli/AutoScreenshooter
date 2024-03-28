import QtCore
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtWebEngine
import QtQuick.Dialogs
import QtQuick.Controls.Imagine
import com.mycompany.qmlcomponents

Rectangle {
    id: table

    states: [
        State {
            name: "start"

            PropertyChanges {
                target: timer
                running: true
            }

            PropertyChanges {
                target: auto
                text: "Остановить"
                onClicked: table.state = "close"
            }
        },

        State {
            name: "close"

            PropertyChanges {
                target: timer
                running: false
            }

            PropertyChanges {
                target: auto
                text: "Продолжить"
                onClicked: table.state = "start"
            }
        }
    ]

    TableModel{
        id: tableModelId
    }

    TableView {
        id: tableViewId
        anchors.fill: table
        clip: true

        resizableColumns: true
        boundsBehavior: Flickable.StopAtBounds

        ScrollBar.vertical: ScrollBar {
            id: scroll
            property real step: 1 / tableModelId.rowCount()
            stepSize: step
        }
        model: tableModelId

        columnWidthProvider: function (column) {
            return tableViewId.model ? tableViewId.width/tableViewId.model.columnCount() : 0
        }

        selectionModel: ItemSelectionModel {
            id:ism
            model: tableModelId
        }

        selectionBehavior: TableView.SelectRows

        delegate: Rectangle {
            id: cell
            implicitWidth: tableViewId.columnWidthProvider(column)
            implicitHeight: 70
            color: {
                selected ? "lightblue" : palette.base
            }

            required property bool selected

            Text {
                anchors.horizontalCenter: cell.horizontalCenter
                anchors.verticalCenter: cell.verticalCenter
                text: model.tabledata
                font.pixelSize: 16
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    ism.select(tableModelId.index(row, column), ItemSelectionModel.Select | ItemSelectionModel.Current | ItemSelectionModel.Rows)
                    console.log(ism.selectedIndexes)
                    console.log(ism.hasSelection)
                    console.log(ism.selectedColumns(index))
                }
            }
        }
    }

    property int i: 1

    Timer {
        id: timer
        running: false
        repeat: true
        interval: 1500
        onTriggered: {
            if(i >= tableModelId.rowCount())
                timer.running = false
            else
            {
                scroll.increase()
                console.log(i)
                ism.select(tableModelId.index(i, 0), ItemSelectionModel.Select | ItemSelectionModel.Current | ItemSelectionModel.Rows)
                i++
            }
        }
    }

    Button {
        id: auto
        text: "Автомат"
        anchors{
            bottom: parent.bottom
            right: parent.right
            bottomMargin: 5
            rightMargin: 20
        }
        onClicked: table.state = "start"
    }
}

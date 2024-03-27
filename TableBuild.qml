import QtCore
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtWebEngine
import QtQuick.Dialogs
import com.mycompany.qmlcomponents

Rectangle {
    id: table

    TableModel{
        id: tableModelId
    }

    TableView {
        id: tableViewId
        anchors.fill: table
        topMargin: 50
        clip: true

        boundsBehavior: Flickable.StopAtBounds

        ScrollBar.vertical: ScrollBar {}
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
            color: selected ? "lightblue" : palette.base

            required property bool selected

            Text {
                anchors.horizontalCenter: cell.horizontalCenter
                anchors.verticalCenter: cell.verticalCenter
                text: model.tabledata
                font.pixelSize: 16
            }

            property int count: tableModelId.rowCount

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
        interval: 1000
        onTriggered: {
            if(i >= tableModelId.rowCount)
                timer.running = false
            else
            {
                console.log(i)
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
            rightMargin: 15
        }
        onClicked: timer.running = true
    }
}

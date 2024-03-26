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

        function start()
        {
            for(var i = 0; i < tableModelId.rowCount; ++i)
            {
                console.log(i)
            }
        }

        onStartSignal: start();

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
}

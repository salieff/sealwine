import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import org.salieff.sealwine 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    // color: "#16FF16"
    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        width: 100
        height: 100
        visible: false
        running: false
    }

    ColumnLayout {
        anchors.fill: parent

        RowLayout {
            TextField {
                id: searchText
                z: 2
                Layout.fillWidth: true
                placeholderText: qsTr("Enter request")
                onAccepted: goButton.onClicked()
            }

            Button {
                id: goButton
                text: "Go"
                onClicked: {
                    busyIndicator.running = true
                    busyIndicator.visible = true
                    moreElementsButton.visible = false
                    mainView.model.requestWine(searchText.text)
                }
            }
        }

        ListView {
            id: mainView
            clip: true
            spacing: 15
            Layout.fillWidth: true
            Layout.fillHeight: true
            delegate: SealWineDelegate {
            }
            model: SealWineModel {
                onWhereAreMoreElements: {
                    busyIndicator.running = false
                    busyIndicator.visible = false
                    moreElementsButton.visible = true
                }
                onNoMoreElements: {
                    busyIndicator.running = false
                    busyIndicator.visible = false
                    moreElementsButton.visible = false
                }
            }

            Rectangle {
                anchors.right: parent.right
                anchors.rightMargin: 2
                y: parent.visibleArea.yPosition * parent.height
                width: 6
                radius: 2
                height: parent.visibleArea.heightRatio * parent.height
                color: "black"
                opacity: 0.5
            }
        }

        Button {
            id: moreElementsButton
            Layout.fillWidth: true
            visible: false
            text: "Load more"
            onClicked: {
                busyIndicator.running = true
                busyIndicator.visible = true
                mainView.model.loadMore()
            }
        }
    }
}

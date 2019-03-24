import QtQuick 2.12
import QtQuick.Layouts 1.12

Item {
    width: parent.width
    height: textLayout.implicitHeight + textLayout.anchors.margins * 2

    ColumnLayout {
        id: textLayout
        anchors {
            top: parent.top
            left: parent.left
            margins: 10
        }

        Text {
            text: model.RegCode
        }

        Text {
            text: model.Producer
        }

        Text {
            text: model.OrigName
        }

        Text {
            text: model.Alcohol
        }

        Text {
            text: model.Caps
        }
    }

    Image {
        anchors {
            top: parent.top
            right: parent.right
            margins: 10
        }

        fillMode: Image.PreserveAspectFit
        height: textLayout.implicitHeight
        source: model ? model.Image : ""
    }
}

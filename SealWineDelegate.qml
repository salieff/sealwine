import QtQuick 2.12
import QtQuick.Layouts 1.12

RowLayout {
    width: parent.width

    ColumnLayout {
        id: textLayout
        Layout.margins: 15

        Text {
            Layout.fillWidth: true
            wrapMode: Text.Wrap
            text: model.RegCode
        }

        Text {
            Layout.fillWidth: true
            wrapMode: Text.Wrap
            text: model.Producer
        }

        Text {
            Layout.fillWidth: true
            wrapMode: Text.Wrap
            text: model.OrigName
        }

        Text {
            Layout.fillWidth: true
            wrapMode: Text.Wrap
            text: model.Alcohol
        }

        Text {
            Layout.fillWidth: true
            wrapMode: Text.Wrap
            text: model.Caps
        }
    }

    Image {
        Layout.preferredHeight: textLayout.implicitHeight
        // Layout.preferredWidth: paintedWidth
        Layout.preferredWidth: sourceSize.width * textLayout.implicitHeight / sourceSize.height
        Layout.margins: 15
        fillMode: Image.PreserveAspectFit
        source: model ? model.Image : ""
    }
}

import QtQuick 2.12
import QtQuick.Layouts 1.12

RowLayout {
    width: parent.width

    ColumnLayout {
        id: textLayout
        Layout.margins: 15

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

    Item {
        Layout.fillWidth: true
    }

    Image {
        fillMode: Image.PreserveAspectFit

        Layout.margins: 15
        Layout.preferredHeight: textLayout.implicitHeight
        Layout.preferredWidth: sourceSize.width * textLayout.implicitHeight / sourceSize.height

        source: model ? model.Image : ""
    }
}

import QtQuick 2.12
import QtQuick.Layouts 1.12

RowLayout {
    width: parent.width

    Item {
        Layout.fillHeight: true
        Layout.fillWidth: true

        Flickable {
            id: textFlick
            anchors.fill: parent
            anchors.margins: 10
            contentWidth: textLayout.implicitWidth

            clip: true

            ColumnLayout {
                id: textLayout

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
        }

        Image {
            anchors {
                top: parent.top
                right: parent.right
                topMargin: 15
            }

            source: "arrow.png"
            visible: textFlick.width < textFlick.contentWidth
                     && textFlick.contentX < (textFlick.contentWidth - textFlick.width)
        }
    }

    Image {
        Layout.preferredHeight: textLayout.implicitHeight
        // Layout.preferredWidth: paintedWidth
        Layout.preferredWidth: sourceSize.width * textLayout.implicitHeight / sourceSize.height
        Layout.margins: 10
        fillMode: Image.PreserveAspectFit
        source: model ? model.Image : ""
    }
}

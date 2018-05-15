import QtQuick 2.6

Item {
    id: root
    width: 760
    height: 650

    ListView {
        id: tools
        width: 420
        flickableDirection: Flickable.HorizontalFlick
        cacheBuffer: 319
        anchors.verticalCenterOffset: 1
        anchors.horizontalCenterOffset: 0
        anchors.rightMargin: 0
        anchors.bottomMargin: -1
        anchors.leftMargin: 0
        anchors.topMargin: 1
        anchors.fill: parent
        model: nestedModel
        anchors.centerIn: parent
        orientation: ListView.Horizontal
        spacing: 10
        delegate: categoryDelegate
    }

    ListModel {
        id: nestedModel
        ListElement {
            categoryName: "Tools"
            collapsed: true

            // A ListElement can't contain child elements, but it can contain
            // a list of elements. A list of ListElements can be used as a model
            // just like any other model type.
            subItems: [
                ListElement { itemName: "Pencil" },
                ListElement { itemName: "Eraser" },
                ListElement { itemName: "Paint-bucket" },
                ListElement { itemName: "Text" },
                ListElement { itemName: "More..." }
            ]
        }

        ListElement {
            categoryName: "Stamps"
            collapsed: true
            subItems: [
                ListElement { itemName: "Birds" },
                ListElement { itemName: "Cars" },
                ListElement { itemName: "Trees" },
                ListElement { itemName: "Tux" },
                ListElement { itemName: "More..." }
            ]
        }

        ListElement {
            categoryName: "Colors"
            collapsed: true
            subItems: [
                ListElement { itemName: "#F08080" },
                ListElement { itemName: "#00FF00" },
                ListElement { itemName: "#0000FF" },
                ListElement { itemName: "#FF00FF" },
                ListElement { itemName: "#800080" },
                ListElement { itemName: "#C0C0C0" },
                ListElement { itemName: "More..." }
            ]
        }

        ListElement {
            categoryName: "Shapes"
            collapsed: true
            subItems: [
                ListElement { itemName: "Rectangle" },
                ListElement { itemName: "Circle" },
                ListElement { itemName: "Triangle" },
                ListElement { itemName: "Ellipse" },
                ListElement { itemName: "More..." }
            ]
        }
    }

    Component {
        id: categoryDelegate
        Column {
            width: root.width / 4.3

            Rectangle {
                id: categoryItem
                border.color: "black"
                border.width: 5
                radius: 50
                color: "white"
                height: 50
                width: root.width / 6

                Text {
                    //anchors.verticalCenter: parent.verticalCenter
                    anchors.centerIn: parent
                    x: 15
                    font.pixelSize: 24
                    text: categoryName
                }
                MouseArea {
                    anchors.fill: parent

                    // Toggle the 'collapsed' property
                    onClicked: nestedModel.setProperty(index, "collapsed", !collapsed)
                }
            }

            Loader {
                id: subItemLoader

                // This is a workaround for a bug/feature in the Loader element. If sourceComponent is set to null
                // the Loader element retains the same height it had when sourceComponent was set. Setting visible
                // to false makes the parent Column treat it as if it's height was 0.
                visible: !collapsed
                property variant subItemModel : subItems
                sourceComponent: collapsed ? null : subItemColumnDelegate
                onStatusChanged: if (status == Loader.Ready) item.model = subItemModel
            }
        }

    }

    Component {
        id: subItemColumnDelegate
        Column {
            property alias model : subItemRepeater.model
            width: 200
            Repeater {
                id: subItemRepeater
                delegate: Rectangle {
                    color: "#cccccc"
                    height: 40
                    width: 200
                    border.color: "black"
                    border.width: 2

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        x: 30
                        font.pixelSize: 18
                        text: itemName
                    }
                }
            }
        }
    }

    Image {
        id: boy
        source: "boy.jpg" // source to image 1
        anchors.left: parent.left
        anchors.leftMargin: 35
        y: 109
        z: tools.z - 1
        width: 250
        height: 190
    }

    Image {
        id: girl
        source: "girl.jpg"
        anchors.left: boy.right // source to image 2
        anchors.leftMargin: 11
        y: 117
        z: tools.z - 1
        width: 250
        height: 190
    }

    Image {
        id: panda
        source: "panda.jpeg" // source to image 3
        anchors.top: boy.bottom
        anchors.bottomMargin: 50
        x: 95
        //y: 150
        z: tools.z - 1
        width: 250
        height: 190
        anchors.topMargin: 14
    }

    Row {
        anchors.bottom: parent.bottom
        Image {
            source: "/bar_open.svg"
            height: root.height * 0.15
        }
        Image {
            source: "/bar_home.svg"
            height: root.height * 0.15
        }
        Image {
            source: "/bar_config.svg"
            height: root.height * 0.15
        }
        Image {
            source: "bar_reload.svg"
            height: root.height * 0.15
        }
    }
}

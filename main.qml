import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: root
    visible: true
    width: 960
    height: 640
    minimumWidth: 640
    minimumHeight: 480
    title: qsTr("Chat Room")
    //top menu bar
    Rectangle {
            width: parent.width // 宽度和窗口宽度相同
            height: 50 // 设置条的高度
            color: "steelblue" // 设置条的颜色
            anchors.top: parent.top // 放置在窗口顶部
            Row {
                        anchors.fill: parent

                        Rectangle {
                            border.color: "black" // 左侧rectangle边框颜色
                            border.width: 3 // 左侧rectangle边框宽度
                            width: parent.width / 7 // 左侧rectangle宽度为bar的1/7
                            height: parent.height
                            color: "lightsteelblue"

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    popup.x = (root.width - popup.width) / 2;
                                    popup.y = (root.height - popup.height) / 2;
                                    popup.visible = true;
                                }
                            }
                            Text {
                                anchors.centerIn: parent
                                text: "Create"
                            }
                        }

                        Rectangle {
                            border.color: "black" // 左侧rectangle边框颜色
                            border.width: 3 // 左侧rectangle边框宽度
                            width: parent.width  / 7
                            height: parent.height
                            color: "lightsteelblue"
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    popup1.x = (root.width - popup1.width) / 2;
                                    popup1.y = (root.height - popup1.height) / 2;
                                    popup1.visible = true;
                                }
                            }
                            Text {
                                anchors.centerIn: parent
                                text: "Enter"

                            }
                        }
                    }
        }
    Rectangle {
        id: sidebar
        color: "#293846"
        width: 240
        height: parent.height - 50
        anchors.top: parent.top - 50
        anchors.bottom: parent.bottom
        ListView {
                id: sidebarlist
                width: 240
                height: parent.height
                model: ListModel {
                    ListElement { text: "Room 1" }
                    ListElement { text: "Room 2" }
                    ListElement { text: "Room 3" }
                    ListElement { text: "Room 4" }
                }

                delegate: Item {
                    width: parent.width
                    height: 40
                    Rectangle {
                        width: parent.width
                        height: parent.height
                        color: ListView.isCurrentItem ? "#354759" : "#293846"
                        Text {
                            text: model.text
                            anchors.centerIn: parent
                            color: ListView.isCurrentItem ? "white" : "black"
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                sidebarlist.currentIndex = index
                                contentText.text = model.text + " content"
                            }
                        }
                    }
                }
            }

        // Sidebar content, such as logo and menu items, can be added here
    }

    Rectangle {
        id: content
        color: "#2e3e4e"
        width: parent.width - 240
        height: parent.height-50
        anchors.left: sidebar.right
        anchors.top: parent.top-50
        anchors.bottom: parent.bottom

        // Content area, where different pages can be loaded using a Loader
        Text {
            id: contentText
            anchors.centerIn: parent
            font.pixelSize: 20
            color: "white"
            text: "Room 1 content"
        }
    }


    //popup window
    Rectangle {
            id: popup
            width: 450
            height: 300
            color: "lightblue"
            border.color: "black"
            border.width: 2
            visible: false
            radius: 10
            Column {
                anchors.centerIn: parent
                spacing: 10

                TextField {
                    id: roomNameField
                    placeholderText: "Room Name"
                    width: parent.width
                }

                TextField {
                    id: passwordField
                    placeholderText: "Password"
                    width: parent.width
                }

                TextField {
                    id: nicknameField
                    placeholderText: "Nickname"
                    width: parent.width
                }

                Row {
                    spacing: 10
                    anchors.horizontalCenter: parent.horizontalCenter

                    Button {
                        text: "Create Room"
                        onClicked: {
                            // 在此处处理创建房间的逻辑
                            console.log("Room Name:", roomNameField.text)
                            console.log("Password:", passwordField.text)
                            console.log("Nickname:", nicknameField.text)
                            popup.visible = false
                        }
                    }

                    Button {
                        text: "Close"
                        onClicked: popup.visible = false
                    }
                }
            }
        }
        //弹窗二代码
        Rectangle {
            id: popup1
            width: 450
            height: 300
            color: "lightblue"
            border.color: "black"
            border.width: 2
            visible: false
            radius: 10
            Column {
                anchors.centerIn: parent
                spacing: 10

                TextField {
                    id: roomNameField1
                    placeholderText: "Room Name"
                    width: parent.width
                }

                TextField {
                    id: passwordField1
                    placeholderText: "Password"
                    width: parent.width
                }

                TextField {
                    id: nicknameField1
                    placeholderText: "Nickname"
                    width: parent.width
                }
                Row {
                    spacing: 10
                    anchors.horizontalCenter: parent.horizontalCenter

                    Button {
                        text: "Join Room"
                        onClicked: {
                            // 在此处处理创建房间的逻辑
                            console.log("Room Name:", roomNameField1.text)
                            console.log("Password:", passwordField1.text)
                            console.log("Nickname:", nicknameField1.text)
                            popup1.visible = false
                        }
                    }

                    Button {
                        text: "Close"
                        onClicked: popup1.visible = false
                    }
                }
            }
        }
}

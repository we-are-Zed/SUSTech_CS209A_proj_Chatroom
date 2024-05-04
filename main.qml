import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 1250
    height: 750
    title: "Chatting rooooooooooom"
    id: root
    Button {
        text: "创建房间"

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.topMargin: 20
        onClicked: {
            popup.x = (parent.width - popup.width) / 2;
            popup.y = (parent.height - popup.height) / 2;
            popup.visible = true;
        }
    }
    Button {
            text: "加入房间"
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 150
            anchors.topMargin: 20
            onClicked: {
                popup1.x = (parent.width - popup.width) / 2;
                popup1.y = (parent.height - popup.height) / 2;
                popup1.visible = true;
            }
        }
    //列表代码

    Text {
        text: "聊天室列表"
        font.bold: true
        font.pointSize: 14
        anchors {
            top: parent.top
            topMargin: 120
            left: parent.left
            leftMargin: 20
        }
    }
    ListView {
        id: listView
        width: parent.width
        height: 150
        anchors {
            top: parent.top
            topMargin: 150
            horizontalCenter: parent.horizontalCenter
        }
        model: ListModel {
            ListElement { name: "Chat Room 1" }
            ListElement { name: "Chat Room 2" }
            ListElement { name: "Chat Room 3" }
            // Add more chat rooms as needed
        }

        delegate: Button {
            width: parent.width
            height: 40

            text: model.name
            onClicked: {
                console.log("Clicked:", model.name)
                // 在此处处理点击按钮的逻辑
                popup2.x = (root.width - popup.width) / 2;
                popup2.y = (root.height - popup.height) / 2;
                popup2.visible = true;
            }
            clip: true
        }
    }

    //弹窗1代码
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
    //弹窗三代码
    Rectangle {
        id: popup2
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
                id: passwordField2
                placeholderText: "Password"
                width: parent.width
            }

            TextField {
                id: nicknameField2
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

                        console.log("Password:", passwordField2.text)
                        console.log("Nickname:", nicknameField2.text)
                        popup2.visible = false
                    }
                }

                Button {
                    text: "Close"
                    onClicked: popup2.visible = false
                }
            }
        }
    }
}

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
            color: "#498C8B" // 设置条的颜色
            anchors.top: parent.top // 放置在窗口顶部
            Row {
                        anchors.fill: parent

                        Rectangle {
                            border.color: "#498C8B" // 左侧rectangle边框颜色
                            border.width: 3 // 左侧rectangle边框宽度
                            width: parent.width / 7 // 左侧rectangle宽度为bar的1/7
                            height: parent.height
                            color: "#E2F5EA"

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
                            border.color: "#498C8B" // 左侧rectangle边框颜色
                            border.width: 3 // 左侧rectangle边框宽度
                            width: parent.width  / 7
                            height: parent.height
                            color: "#E2F5EA"
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
        color: "#3D5F69"
        width: 240
        height: parent.height - 50
        anchors.top: parent.top - 50
        anchors.bottom: parent.bottom
        ListView {
                id: sidebarlist
                width: 240
                height: parent.height
                model: ListModel {
                    id: chatRoomList
                    ListElement { text: "Room 1" }
                    ListElement { text: "Room 2" }
                    ListElement { text: "Room 3" }
                    ListElement { text: "Room 4" }
                }

                delegate: Item {
                    width: parent.width
                    height: 50

                    Row {
                        anchors.fill: parent
                        spacing: 10

                        Button {
                            text: model.text
                            onClicked: {
                                console.log(model.text + " button clicked")
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
        height: parent.height - 50
        anchors.left: sidebar.right
        anchors.top: parent.top - 50
        anchors.bottom: parent.bottom

        Column {
            anchors.fill: parent

            ListView {
                id: messageList
                anchors.fill: parent
                height: parent.height - 100 // 为输入区和按钮留出空间
                model: messageModel // 需要在适当的地方定义这个模型
                delegate: Rectangle {
                        width: parent.width-100
                        height: 70
                        color: "#f0f0f0"
                        border.color: "#e0e0e0"
                        border.width: 1

                        Column {
                            anchors.fill: parent
                            Text {
                                text: "Time: " + model.timestamp.toLocaleString(Qt.locale(), "yyyy-MM-dd hh:mm:ss")
                                color: "grey"
                            }

                            Text {
                                text: "User: " + model.userName
                                color: "black"
                                font.bold: true
                            }

                            Text {
                                text: "Message: " + model.text
                                color: "blue"
                            }
                        }
                    }
            }

            Rectangle {
                color: "#354759"
                height: 50
                width: parent.width - 250 // 留出按钮空间
                anchors.bottom: parent.bottom
                TextField {
                    id: inputField
                    anchors.fill: parent
                    placeholderText: qsTr("Type your message here...")
                }
            }

            Row {
                spacing: 10
                height: 50
                width: 250 // 给按钮足够空间
                anchors.right: parent.right // 与输入框右侧对齐
                anchors.bottom: parent.bottom

                Button {
                    text: "Send"
                    onClicked: {
                        // 发送按键逻辑
                    }
                }
            }
        }

        ListView {
            width: 100
            height: parent.height
            anchors.right: parent.right
            model: userListModel // 需要在适当的地方定义这个模型
            delegate: Rectangle {
                    width: parent.width
                    height: 50
                    color: "#649DAD"
                    border.color: "#649DAD"
                    border.width: 1

                    Row {
                        anchors.fill: parent
                        Text {
                            text: "User: " + model.userName
                            color: "black"
                        }
                    }
                }
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

            signal createRoom(string roomName, string password, string nick)
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
                            popup.createRoom(roomNameField.text, passwordField.text, nicknameField.text)
                            // console.log("Room Name:", roomNameField.text)
                            // console.log("Password:", passwordField.text)
                            // console.log("Nickname:", nicknameField.text)
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

            signal joinRoom(string roomName, string password, string nick)
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
                            popup1.joinRoom(roomNameField1.text, passwordField1.text, nicknameField1.text)
                            //console.log("Room Name:", roomNameField1.text)
                            //console.log("Password:", passwordField1.text)
                            //console.log("Nickname:", nicknameField1.text)
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

        ListModel {
            id: messageModel
            ListElement { userName: "Alice"; timestamp: "2021-01-01 10:00:00"; text: "Hello, welcome to the chat!" }
            ListElement { userName: "Bob"; timestamp: "2021-01-01 10:05:00"; text: "This is a test message." }
            // 可以继续添加更多消息
        }

        ListModel {
            id: userListModel
            ListElement { userName: "User1" }
            ListElement { userName: "User2" }
            // 可以继续添加更多用户
        }
        Connections {
            target: Server
            //server应该有一个signal为chatRoomListChanged（string roomName）,传入参数为新房间的名字
            //当chatroom列表发生变化时，会向qml发送chatRoomListChanged信号，当qml收到信号时，会做出如下的变化（在sidebar的list append新的list element）
            //OnChatRoomListChanged: {
              //chatRoomList.append(roomName);
            //}
        }
        function onNewMessageReceived(message) {
            messageModel.append({
                userName: message.userName,
                timestamp: message.timestamp,
                text: message.text
            });
        }

            function onUserListUpdated(user) {

                    userListModel.append({
                userName: user.userName,
                IP: user.IP});

            }


}

# UML
设计思路 [procedure](https://chatgpt.com/share/c20d6e9e-6020-4498-91e8-470a2cbb2a5a)

uml是干什么的，是分享思路的，你设计阶段画个草图人能看懂就行了。但是我猜你一堆b事，那就ai吧。还有UML你那一堆b符号有什么大病，多写点注释会死是把，喜欢虚实结合和不同形状箭头，你怎么不去用道尔顿元素符号呢😅😓😇
## Client

```plantuml
@startuml
!define RECTANGLE class
!define ENTITY entity

ENTITY ChatClient {
  +mainWindow: MainWindow
  +roomController: RoomController
  +messageController: MessageController
  +serverController: ServerController
  +connect(peer: String)
  +sendMessage(message: Message)
  +receiveMessage(message: Message)
}

RECTANGLE MainWindow {
  +open()
  +close()
  +displayMessage(message: Message)
  +sendMessage()
  +onMessageReceived(message: Message)
}

RECTANGLE RoomController {
  +createRoom(roomName: String)
  +connectToRoom(roomName: String)
  +switchRoom(roomName: String)
}

RECTANGLE MessageController {
  +transmitMessage(message: Message, toPeer: String)
  +receiveMessage(message: Message, fromPeer: String)
  +storeMessage(message: Message)
  +exportMessages(filePath: String)
  +loadMessages(filePath: String)
  +handleClientConnection(peer: String)
  +manageBlacklist(peer: String, action: String)
}

RECTANGLE ServerController {
  +publishRoom(roomName: String)
  +fetchRooms(): List<String>
  +syncBlacklist(blacklist: List<String>)
  +updateBlacklist(peer: String, action: String)
}

ENTITY Message {
  +messageId: int
  +timestamp: Date
  +sender: User
  +type: MessageType
  +content: MessageContent
}

ENTITY User {
  +userId: String
}

enum MessageType {
  TEXT
  AUDIO
  VIDEO
}

abstract class MessageContent {
  +display(): void
  +serialize(): String
}

ENTITY TextContent {
  +text: String
  +display(): void
  +serialize(): String
}

ENTITY MediaContent {
  +url: String
  +description: String
  +display(): void
  +serialize(): String
}

ENTITY BlacklistManager {
  +addToBlacklist(peer: String)
  +removeFromBlacklist(peer: String)
  +isBlacklisted(peer: String): Boolean
  +syncWithServer()
}

ChatClient --|> MainWindow
ChatClient --|> RoomController
ChatClient --|> MessageController
ChatClient --|> ServerController
ChatClient --> Message
MainWindow --> Message
RoomController --> ChatClient
MessageController --> Message
MessageController --> BlacklistManager
ServerController --> RoomController
ServerController --> BlacklistManager

Message --> User
Message --> MessageType
Message --> MessageContent

MessageContent <|-- TextContent
MessageContent <|-- MediaContent

@enduml

```
For github(which can't render plantuml): ![client](../imgs/client.png)
## Server

```plantuml
@startuml
!define RECTANGLE class
!define ENTITY entity

ENTITY Server {
  +storageModule: StorageModule
  +controllerModule: ControllerModule
  +connectionHandlerModule: ConnectionHandlerModule
}

ENTITY StorageModule {
  +rooms: List<Room>
  +clients: List<Client>
  +cleanup(): void
}

ENTITY Room {
  +name: String
  +password: String
  +clients: List<Client>
  +addClient(client: Client): void
  +removeClient(client: Client): void
  +isEmpty(): Boolean
  +verifyPassword(password: String): Boolean
  +isClientBlacklisted(client: Client): Boolean
}

ENTITY Client {
  +name: String
  +joinedRooms: List<Room>
  +heartbeat(): void
  +joinRoom(room: Room): void
  +leaveRoom(room: Room): void
}

RECTANGLE ControllerModule {
  +createRoom(name: String, password: String): Room
  +createClient(name: String): Client
  +getRoomClients(roomName: String, password: String, clientId: uint64): List<Client>
  +handleHeartbeat(client: Client): void
}

RECTANGLE ConnectionHandlerModule {
  +threadPool: ThreadPool
  +handleConnection(grpcRequest: GrpcRequest): void
  +asyncProcess(grpcRequest: GrpcRequest): void
}

RECTANGLE ThreadPool {
  +execute(task: Runnable): void
}

abstract class GrpcRequest {
}

RECTANGLE RegisterClientRequest {
  +name: String
}

RECTANGLE RegisterClientReply {
  +success: bool
  +message: String
  +clientId: uint64
}

RECTANGLE PublishRoomRequest {
  +name: String
  +password: String
}

RECTANGLE PublishRoomReply {
  +success: bool
  +message: String
}

RECTANGLE GetRoomPeersRequest {
  +name: String
  +password: String
  +clientId: uint64
}

RECTANGLE GetRoomPeersReply {
  +success: bool
  +peers: List<String>
  +message: String
}

RECTANGLE HeartBeatRequest {
  +clientId: uint64
}

RECTANGLE HeartBeatReply {
  +success: bool
}

Server --> StorageModule
Server --> ControllerModule
Server --> ConnectionHandlerModule
StorageModule --> Room
StorageModule --> Client
Room --> Client
Client --> Room
ControllerModule --> StorageModule
ControllerModule --> Room
ControllerModule --> Client
ConnectionHandlerModule --> ControllerModule
ConnectionHandlerModule --> ThreadPool
ConnectionHandlerModule --> GrpcRequest

GrpcRequest <|-- RegisterClientRequest
GrpcRequest <|-- PublishRoomRequest
GrpcRequest <|-- GetRoomPeersRequest
GrpcRequest <|-- HeartBeatRequest

GrpcRequest <|-- RegisterClientReply
GrpcRequest <|-- PublishRoomReply
GrpcRequest <|-- GetRoomPeersReply
GrpcRequest <|-- HeartBeatReply

@enduml

```

For github(which can't render plantuml): ![server](../imgs/server.png)


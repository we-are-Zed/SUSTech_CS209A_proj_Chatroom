目录下每个json文件对应一个聊天室的聊天记录, json 格式定义如下

```json
{
  "chatroom": {
    "id": "chatroom-1234",
    "name": "Global Chatroom",
    "messages": [
      {
        "message_id": "msg-001",
        "timestamp": "2024-05-09T10:30:00Z",
        "sender": {
          "user_id": "user-1001",
          "username": "Alice",
          "ip": "192.168.1.10"
        },
        "type": "text",
        "content": "Hello everyone!"
      },
      {
        "message_id": "msg-002",
        "timestamp": "2024-05-09T10:32:00Z",
        "sender": {
          "user_id": "user-1002",
          "username": "Bob",
          "ip": "192.168.1.11"
        },
        "type": "text",
        "content": "Hi Alice!"
      },
      {
        "message_id": "msg-003",
        "timestamp": "2024-05-09T10:35:00Z",
        "sender": {
          "user_id": "user-1003",
          "username": "Charlie",
          "ip": "192.168.1.12"
        },
        "type": "video",
        "content": {
          "url": "https://example.com/video123.mp4",
          "description": "A short video clip"
        }
      },
      {
        "message_id": "msg-004",
        "timestamp": "2024-05-09T10:40:00Z",
        "sender": {
          "user_id": "user-1004",
          "username": "David",
          "ip": "192.168.1.13"
        },
        "type": "audio",
        "content": {
          "url": "https://example.com/audio123.mp3",
          "description": "An audio message"
        }
      }
    ],
    "participants": [
      {
        "user_id": "user-1001",
        "username": "Alice",
        "ip": "192.168.1.10"
      },
      {
        "user_id": "user-1002",
        "username": "Bob",
        "ip": "192.168.1.11"
      },
      {
        "user_id": "user-1003",
        "username": "Charlie",
        "ip": "192.168.1.12"
      },
      {
        "user_id": "user-1004",
        "username": "David",
        "ip": "192.168.1.13"
      }
    ],
    "blacklist": [
      {
        "user_id": "user-2001",
        "username": "Eve",
        "ip": "192.168.1.14",
        "reason": "Spamming"
      },
      {
        "user_id": "user-2002",
        "username": "Mallory",
        "ip": "192.168.1.15",
        "reason": "Harassment"
      }
    ]
  }
}
```

多媒体文件除了通过 url 传输，还可以访问本地保存的文件

server 端数据结构由于不需要持久化，固直接给出 C++ 类定义

```cpp
struct Client{
  size_t userID;
  std::string username;
  std::string ip;
  std::list<std::string> joinedRooms;
};

struct ChatRoom{
  size_t romeID;
  std::string roomName;
  std::string password;
  std::list<std::shared_ptr<Client>> users;
};

std::unordered_map<size_t, std::shared_ptr<Client>> clients; // 维护在线客户端
std::unordered_map<std::string, ChatRoom> chatrooms; // 维护在线房间
```


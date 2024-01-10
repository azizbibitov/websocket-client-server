const express = require("express");
const app = express();
const server = require("http").createServer(app);
const port = 3000;

const WebSocket = require("ws");
const wss = new WebSocket.Server({ server: server });

wss.on("connection", function connection(ws) {
  console.log("A new client Connected!");
  ws.send("Welcome New Client!");

  ws.on("message", function incoming(message) {
    console.log("received: %s", message);
    const stringMessage = message.toString();
    wss.clients.forEach(function each(client) {
      if (client !== ws && client.readyState === WebSocket.OPEN) {
        client.send(stringMessage);
      }
    });
  });

  ws.on("close", function close() {
    console.log("A client disconnected!");
  });
});

app.get("/", (req, res) => {
  res.send("Hello, World!");
});

server.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});

## About

This is a fork of the original bluechatter: https://github.com/IBM-Bluemix/bluechatter
The BlueChatter app is a very simple chat/IRC type app for your browser.
It is very basic, you just go to the app, enter a user name and start
chatting.

For a demonstration of this application you can watch the following
YouTube video.

[![BlueChatter](https://img.youtube.com/vi/i7_dQQy40ZQ/0.jpg?time=1398101975441)](http://youtu.be/i7_dQQy40ZQ)

## Deploy Toolchain
To get started, click **Create toolchain**.

[![Deploy To Bluemix](https://new-console.ng.bluemix.net/devops/graphics/create_toolchain_button.png)](https://new-console.ng.bluemix.net/devops/setup/deploy/?repository=https%3A//github.com/rvennam/bluechatter)

## Technologies
BlueChatter uses [Node.js](http://nodejs.org/) and
[Express](http://expressjs.com/) for the server.  On the frontend
BlueChatter uses [Bootstrap](http://getbootstrap.com/) and
[JQuery](http://jquery.com/).  The interesting part of this application
is how the communication of messages is done.  The application uses [long
polling](http://en.wikipedia.org/wiki/Push_technology#Long_polling) to enable
the clients (browsers) to listen for new messages.  Once the
app loads a client issues a request to the server.  The server waits to respond
to the request until it receives a message.  If no message is received from any
of the chat participants it responds back to the client with a 204 - no content.
As soon as the client gets a response from the server, regardless of whether that
response contains a message or not, the client will issue another request and
the process continues.

One of the goals of this application is to demonstrate scaling in Bluemix.
As we know when you scale an application in Bluemix you essentially are
creating multiple instance of the same application which users will connect
to at random.  In other words there are multiple BlueChatter servers running
at the same time.  So how do we communicate chat messages between the servers?
We use the [pubsub feature of Redis](http://redis.io/topics/pubsub) to solve
this.  All servers bind to a single
Redis instance and each server is listening for messages on the same channel.
When one chat server receives a chat message it publishes an event to Redis
containing the message.  The other servers then get notifications of the new
messages and notify their clients of the.  This design allows BlueChatter to
scale nicely to meet the demand of its users.

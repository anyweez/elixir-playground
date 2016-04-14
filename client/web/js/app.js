import {Socket} from "phoenix-socket"

window.addEventListener('load', function() { 
    var dateformat = require('dateformat'); // excessive, clean up post-POC
    
    // Quickly set up templates and find some DOM elements
    var sendButton = document.getElementById('send-msg');
    var messageBox = document.getElementById('message');
    var chatBox = document.getElementById('chat-messages');
    var render = _.template(document.getElementById('message-template').textContent);
    var highlight = true;
    
    // Phoenix stuff
    let socket = new Socket("ws://localhost:4000/socket", {params: {userToken: "123"}})
    socket.connect()
    
    let channel = socket.channel("world:first", {});
    channel.on('new_msg', (msg) => {
        console.log('From server: ', msg);
        
        var el = document.createElement('li');
        el.classList.add('message');
        if (highlight) el.classList.add('highlight');
        highlight = !highlight;
        
        el.innerHTML = render({
            when: dateformat(new Date(), 'mmm d @ h:MM'),
            message: msg.body,
        });
        
        chatBox.appendChild(el);
    });

    channel.join()
        .receive("ok", resp => { console.log("Joined successfully", resp) })
        .receive("error", resp => { console.log("Unable to join", resp) })
        
    sendButton.addEventListener('click', function() {
        var message = messageBox.value;
        console.log('attempting to send...')
        channel.push('new_msg', {
            body: message,
        }, 10000)       
            .receive("ok", (msg) => console.log("message sent!", msg) )
            .receive("error", (reasons) => console.log("serverside error", reasons) )
            .receive("timeout", () => console.log("Networking issue...") ); // timeout?
    });
})
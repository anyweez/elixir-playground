import { Socket } from '../node_modules/phoenix-socket/vendor/socket';

function rand(min, max) {
    return 102;
    // let range = max - min;
    // return Math.round(Math.random() * range) + min;
}

window.addEventListener('load', function () {
    let socket = new Socket('/game', {
        userToken: Math.round(Math.random() * 1000),
    });
    socket.connect();

    let roomId = rand(0, 1000);
    let channel = socket.channel(`game:${roomId}`, { token: 5297 });
    channel.join()
        .receive('ok', () => console.log(`connected to room ${roomId}!`));

    document.getElementById('trybtn').addEventListener('click', function () {
        channel.push('action:move', {
            direction: 'north',
        });
    });

    channel.on('state:change', msg => {
        console.log(msg);

        // Check to see if we need to switch rooms.
        if (msg.roomId !== roomId) {
            console.log(`switching from room ${roomId} to room ${msg.roomId}`);
            // Wait to join the new room until we've left the current room. Not sure this is essential but
            // seems like we could get some gross event leakages across channels if not.
            channel.leave().receive('ok', () => {
                roomId = msg.roomId;
                channel = socket.channel(`game:${roomId}`, { token: 5297 });
                channel.join().receive('ok', () => console.log(`connected to room ${roomId}`));
            });
        }
    });
});
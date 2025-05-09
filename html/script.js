window.addEventListener('message', function (event) {
    const beltIcon = document.getElementById('beltIcon');

    if (event.data.show !== undefined) {
        document.getElementById('hud').style.display = event.data.show ? 'block' : 'none';
    }

    if (event.data.speed !== undefined && event.data.fuel !== undefined) {
        document.getElementById('speed').innerText = event.data.speed.toString().padStart(3, '0');
        document.getElementById('fuel').innerText = event.data.fuel + ' Fuel';
    }

    if (event.data.seatbelt !== undefined) {
        if (event.data.seatbelt === "on") {
            beltIcon.classList.remove("flash");
            beltIcon.classList.add("on");
        } else {
            beltIcon.classList.remove("on");
        }
    }

    if (event.data.flashBelt !== undefined) {
        if (event.data.flashBelt) {
            beltIcon.classList.add("flash");
        } else {
            beltIcon.classList.remove("flash");
        }
    }
});

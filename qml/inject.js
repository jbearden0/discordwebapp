function handler() {
    console.log('Injecting ubuntu touch styling fixes');

    var style = document.createElement('style');
    style.type = 'text/css';
    style.appendChild(document.createTextNode(
        '.smartbanner { display: none !important; } ' +
        '.drawer-container { max-width: 94% !important; left: 3% !important; } ' +
        '.member-stats .progress-container .progress { min-width: 100px !important; } ' +
        '#loading-screen-inapp p, #loading-screen-inapp div { width: 100% !important; } ' +
        '.quick-menu .dropdown-menu { max-width: 18em; } ' +
        '.quick-menu .dropdown-item { width: 100%; } ' +
        '.chat-row .container-fluid { height: 20em; overflow: scroll; } ' +
        '.notifications { max-height: 20em; overflow: scroll; }'
    ));

    document.head.appendChild(style);
}


window.addEventListener('load', handler, false);
document.addEventListener('deviceready', handler);
document.addEventListener('DOMContentLoaded', handler);

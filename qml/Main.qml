/*
 * Copyright (C) 2020  James D Bearden
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * discordwebapp is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtWebEngine 1.7
//import QtQuick.Layouts 1.3
//import Qt.labs.settings 1.0
import Ubuntu.Components 1.3 as Ubuntu
import Morph.Web 0.1

ApplicationWindow {
    id: root

    visible: true
    width: units.gu(50)
    height: units.gu(75)
    color: '#43286A'

    WebContext {
        id: webcontext
        userAgent: 'Mozilla/5.0 (Linux; Android 5.0; Nexus 5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.102 Mobile Safari/537.36 Ubuntu Touch Webapp'

        userScripts: [
            WebEngineScript {
                injectionPoint: WebEngineScript.DocumentCreation
                sourceUrl: Qt.resolvedUrl('inject.js')
                worldId: WebEngineScript.MainWorld
            }
        ]
    }

    WebView {
        id: webview
        anchors.fill: parent

        context: webcontext
        url: 'https://www.discord.com/channels/@me'

        function navigationRequestedDelegate(request) {
            var url = request.url.toString();
            var isvalid = false;

            if (!url.match('(http|https)://www.discord.com/(.*)')) {
                Qt.openUrlExternally(url);
                request.action = WebEngineNavigationRequest.IgnoreRequest;
            }
        }
    }

    Connections {
        target: Ubuntu.UriHandler
        onOpened: {
            webview.url = uris[0];
        }
    }

    Component.onCompleted: {
        if (Qt.application.arguments[1] && Qt.application.arguments[1].indexOf('www.discord.com') >= 0) {
            webview.url = Qt.application.arguments[1];
        }
    }
}

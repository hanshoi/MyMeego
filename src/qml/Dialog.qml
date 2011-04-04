/*
 *  Copyright (c) 2011, Juhani Alanko, Marko Silokunnas, Juha Sinkkonen,
 *                      Antti Ruotsalainen, Rawdimension group
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are met:
 *
 *  1. Redistributions of source code must retain the above copyright notice,
 *     this list of conditions and the following disclaimer.
 *  2. Redistributions in binary form must reproduce the above copyright notice,
 *     this list of conditions and the following disclaimer in the documentation
 *     and/or other materials provided with the distribution.
 *  3. Neither the name of the Rawdimension Group nor the names
 *     of its contributors may be used to endorse or promote products derived
 *     from this software without specific prior written permission.
 *
 *     THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 *     AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 *     IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 *     ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 *     LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 *     POSSIBILITY OF SUCH DAMAGE.
 */
import Qt 4.7
import "../javascript/Windowing.js" as Windowing

Rectangle {
    id: container;

    property Theme theme: Theme {}
    signal dialogOpened;
    signal dialogClosed;

    width: window.width;
    height: window.height;
    opacity: 0;
    color: "transparent";

    /* close button */
    Rectangle {
        z:3;
        anchors.top: parent.top;
        anchors.right: parent.right;
        width: theme.closeButtonWidth;
        height: theme.closeButtonHeight;
        color: theme.closeButtonBackgroundColor;
        border.color: theme.closeButtonBorderColor;
        border.width: theme.closeButtonBorderWidth;
        radius: theme.closeButtonRadius;
        gradient: theme.closeButtonBackgroundGradient;

        MouseArea {
            anchors.fill: parent;
            onClicked: { Windowing.closeDialog(); }
        }

        Image {
            source: theme.closeIcon;
            anchors.centerIn: parent;
        }
    }

    Item {
        id: dialogFrameContents;
        anchors.fill: parent;
    }

    states: [
        State {
            name: "visible"
            PropertyChanges {
                target: container;
                opacity: 1;
            }
        }
    ]

    transitions: [
        Transition {
            from: ""
            to: "visible"
            reversible: true;

            NumberAnimation {
                target: container;
                property: "opacity";
                duration: 200;
            }
        }
    ]


}

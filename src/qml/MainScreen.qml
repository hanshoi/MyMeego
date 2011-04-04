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
import backend 1.0
import "../javascript/Windowing.js" as Windowing

Rectangle {
        property Theme theme: Theme{}
        property string selectedDevice: "";

        signal deviceSelected();
        signal deviceMenuBarClosed();

        id: window
        width: 800;
        height: 480;

        MMData {
            id: data;
            deviceId: "1";
            type: "MusicFileList";
            isRequest: true;
            value: "this is a value"
        }

        Dialog {
            id: dialogFrame;
            x: 0;
            y: 0;
            z: 2;
            opacity: 0;

            TransferView {
                id:transferView;

                function clearSelection(){
                    transferTest.clearTransfer();
                }
            }
        }

        Rectangle {
            // used to catch mouse clicks when a dialog is open
            id: deactivator;
            width: window.width;
            height: window.height;
            z: window.z-1;
            //color: "gray";
            Image {
                source: theme.mainScreenBackgroundImage;
                anchors.centerIn: parent;
                anchors.fill: parent;
                smooth: true;
            }
            opacity: 0.0;

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    // do nothing!
                }
            }

            Behavior on opacity {
                NumberAnimation{ duration: 200; }
            }
        }

        function showDeactivator() {
            deactivator.z = transferringDialog.z -1;
            deactivator.opacity = 0.7;
        }

        function hideDeactivator() {
            deactivator.opacity = 0.0;
            deactivator.z = window.z -1;
        }

        TransferringDialog {
            id: transferringDialog;
            z:deviceMenuBar.z+2;
            state: "hidden";
        }

       /*
        * background image
        */
        Image {
            id: backgroundImage;
            source: theme.mainScreenBackgroundImage;
            anchors.centerIn: parent;
            anchors.fill: parent;
            smooth: true;
            z:1;
        }

        /*
         * background color
         */
        Rectangle {
            id: backgroundColor;
            anchors.fill: parent;
            color: theme.mainScreenBackgroundColor;
        }

        DeviceMenuBar {
            id: deviceMenuBar;
            //width: window.width;
            z:3;
            anchors.bottom: window.bottom;
            anchors.horizontalCenter: parent.horizontalCenter;
        }
}

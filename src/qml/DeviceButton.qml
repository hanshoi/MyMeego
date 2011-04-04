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

Item {
            id: deviceButton
            signal clicked;
            property string pathToIcon;
            property string deviceName;
            property Theme theme: Theme {}

            width: icon.width;
            height: theme.mainScreenDeviceMenuHeight;
            clip: true;
            anchors.leftMargin: theme.deviceButtonMargin;
            anchors.rightMargin: theme.deviceButtonMargin;

            /* icon */
            Image {
                id: icon;
                width: theme.deviceMenuButtonWidth;
                height: theme.deviceMenuButtonHeight;
                x: deviceButton.width/2-icon.width/2;
                anchors.verticalCenter: parent.verticalCenter;
                source: pathToIcon;
                smooth: true;
                fillMode: Image.PreserveAspectFit;
                z:1;
            }

            /* Background image */
            /*Rectangle {
                id: background;
                anchors.fill: parent;
                gradient: theme.backgroundGradient;
                z:0;
            }*/

            /* Mouse area */
            MouseArea {
                id: mouseArea;
                anchors.fill: parent;
                onClicked: {
                    parent.clicked();
                }
            }
}
